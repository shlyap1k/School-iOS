//
// HH School
// Created by Shlyap1k.
//

import Foundation
import os.log

// MARK: - DateError

enum DateError: String, Error {
    case invalidDate
}

// MARK: - BaseRestProvider

final class BaseRestProvider: RestProvider {
    // MARK: Lifecycle

    init(requestBuilder: RequestBuilder, decoder: JSONDecoder, refresher: AnyRefresher?) {
        self.requestBuilder = requestBuilder
        self.decoder = decoder
        self.refresher = refresher
        self.refresher?.session = session
        self.refresher?.requestBuilder = requestBuilder
        self.refresher?.decoder = decoder
    }

    // MARK: Internal

    func make<T: Decodable>(_ request: Request, parameters: RestParameters) async -> RestResult<T> {
        do {
            let urlRequest = try requestBuilder.build(request, checkAuthExpired: true)
            log(title: "Request", urlRequest.cURL())
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            guard let urlResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError(kind: .noResponse))
            }
            log(title: "\(urlResponse.statusCode) Response", String(decoding: data, as: UTF8.self))
            refresher?.unauthorized = false
            return try await handle(data, from: urlResponse, parameters: parameters)
        } catch {
            if let requestError = error as? NetworkError {
                switch requestError.kind {
                case .authExpired, .unauthorized:
                    if let refresher {
                        do {
                            try await refresher.refresh()
                            return await make(request, parameters: parameters)
                        } catch {
                            return .failure(NetworkError(kind: .unauthorized))
                        }
                    } else {
                        return .failure(requestError)
                    }
                default:
                    return .failure(requestError)
                }
            } else {
                if let urlError = error as? URLError {
                    return .failure(NetworkError(kind: .system(urlError)))
                } else {
                    return .failure(NetworkError(kind: .unknown))
                }
            }
        }
    }

    func mock<T: Decodable>(_ request: Request, parameters: RestParameters) async -> RestResult<T> {
        guard let data = request.mockData else {
            return .failure(NetworkError(kind: .noMockData))
        }

        if let wrapper = parameters.wrapper {
            guard let decoded = try? decoder.decode(wrapper, from: data),
                  let wrapped = decoded.wrapped as? T
            else {
                return .failure(NetworkError(kind: .decode))
            }
            return .success(wrapped)
        } else {
            guard let decoded = try? decoder.decode(T.self, from: data)
            else {
                return .failure(NetworkError(kind: .decode))
            }
            return .success(decoded)
        }
    }

    // MARK: Private

    private let logger: OSLog? = Bundle.main.bundleIdentifier.map {
        OSLog(subsystem: $0, category: "network")
    }

    private var refresher: AnyRefresher?

    private let requestBuilder: RequestBuilder

    private let decoder: JSONDecoder

    private let session = URLSession.shared

    private func log(title: String, _ info: String) {
        #if DEBUG
            logger.map { os_log("%@:\n%@", log: $0, title, info) }
        #endif
    }

    private func handle<T: Decodable>(
        _ data: Data, from urlResponse: HTTPURLResponse, parameters: RestParameters
    ) async throws -> RestResult<T> {
        decoder.keyDecodingStrategy = parameters.keyDecoding
        decoder.dateDecodingStrategy = parameters.dateDecoding

        switch urlResponse.statusCode {
        case 200 ... 299:
            if let wrapper = parameters.wrapper {
//                do {
//                    let _ = try decoder.decode(wrapper, from: data)
//                } catch {
//                    print(error)
//                }
                guard let decodedResponse = try? decoder.decode(wrapper, from: data),
                      let wrapped = decodedResponse.wrapped as? T
                else {
                    if parameters.wrapper.debugDescription.contains("\(VoidResult.self)"),
                       let result = VoidResult.stub as? T
                    {
                        return .success(result)
                    } else {
                        return .failure(NetworkError(kind: .decode))
                    }
                }
                return .success(wrapped)
            } else {
//                guard let decodedResponse: T = try? decoder.decode(T.self, from: data) else {
//                    return .failure(NetworkError(kind: .decode))
//                }
//                return .success(decodedResponse)
                return .success(data as! T)
            }
        default:
            if let errorWrapper = parameters.errorWrapper {
                guard let errorResponse = try? decoder.decode(errorWrapper, from: data),
                      let error = errorResponse.wrapped as? NetworkError
                else {
                    return .failure(NetworkError(kind: .unexpectedStatusCode))
                }
                return .failure(error)
            }
            return .failure(NetworkError(kind: .unexpectedStatusCode))
        }
    }
}
