//
// HH School
// Created by Shlyap1k.
//

import Foundation

final class BaseRefresher<RefreshResponse: Decodable>: Refresher {
    // MARK: Lifecycle

    init(refreshStrategy: RefreshStrategy) {
        self.refreshStrategy = refreshStrategy
    }

    // MARK: Internal

    var unauthorized: Bool = false

    weak var requestBuilder: RequestBuilder?

    weak var decoder: JSONDecoder?

    weak var session: URLSession?

    let refreshStrategy: RefreshStrategy

    func refresh() async throws {
        if refreshTask == nil, !unauthorized {
            refreshTask = Task { [weak self] in
                do {
                    try await self?._refresh()
                    self?.refreshTask = nil
                } catch let rawError {
                    if let error = rawError as? NetworkError {
                        switch error.kind {
                        case .unauthorized:
                            self?.unauthorized = true
                            self?.refreshStrategy.onRefreshFailed?()
                            self?.refreshTask?.cancel()
                        default:
                            throw rawError
                        }
                    }
                }
            }
        }
        if let refreshTask {
            return try await refreshTask.value
        }
    }

    func _refresh() async throws {
        guard let requestBuilder, let session, let decoder, let request = refreshStrategy.refreshRequest() else {
            throw NetworkError(kind: .refresherInjectError)
        }
        do {
            let urlRequest = try requestBuilder.build(request, checkAuthExpired: false)
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            guard let urlResponse = response as? HTTPURLResponse else {
                throw NetworkError(kind: .noResponse)
            }

            switch urlResponse.statusCode {
            case 200 ... 299:
                decoder.keyDecodingStrategy = refreshStrategy.restParameters.keyDecoding
                if let wrapper = refreshStrategy.restParameters.wrapper {
                    guard let decodedResponse = try? decoder.decode(wrapper, from: data),
                          let wrapped = decodedResponse.wrapped as? RefreshResponse
                    else {
                        throw NetworkError(kind: .decode)
                    }
                    return refreshStrategy.onRefresh?(wrapped) ?? ()
                } else {
                    guard let decodedResponse: RefreshResponse = try? decoder.decode(RefreshResponse.self, from: data)
                    else {
                        throw NetworkError(kind: .decode)
                    }
                    refreshStrategy.onRefresh?(decodedResponse)
                }
            case 400, 401:
                throw NetworkError(kind: .unauthorized)
            default:
                throw NetworkError(kind: .unknown)
            }
        } catch {
            throw error as? NetworkError ?? NetworkError(kind: .unknown)
        }
    }

    // MARK: Private

    private var refreshTask: Task<Void, Error>?
}
