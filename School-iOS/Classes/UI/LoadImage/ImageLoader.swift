//
// HH School
// Created by Shlyap1k.
//

import Combine
import Foundation
import SwiftUI

// MARK: - ImageLoader

class ImageLoader: ObservableObject {
    // MARK: Lifecycle

    init(source: ImageSource) {
        self.source = source
    }

    // MARK: Internal

    // 3
    @Published var phase = AsyncImagePhase.empty

    // ...
    func load() {
        let url: URL
        switch source {
        // 4
        case let .local(name):
            phase = .success(Image(name))
            return
        // 5
        case let .remote(theUrl):
            if let theUrl {
                url = theUrl
                if let cachedImage = try? loadFromCache(before: URLRequest(url: url)) {
                    phase = .success(Image(uiImage: cachedImage))
                    return
                }
            } else {
                phase = .failure(LoaderError.missingURL)
                return
            }
        // 6
        case let .captured(uiImage):
            phase = .success(Image(uiImage: uiImage))
            return
        }

        // 7

        ImageLoader.session.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.phase = .failure(error)
                }
            }, receiveValue: {
                if let image = UIImage(data: $0.data) {
                    self.cache(data: $0.data, for: URLRequest(url: url), response: $0.response)
                    self.phase = .success(Image(uiImage: image))
                } else {
                    self.phase = .failure(LoaderError.failedToDecodeFromData)
                }
            })
            .store(in: &subscriptions)
    }

    // ...

    // MARK: Private

    // 2
    private enum LoaderError: Swift.Error {
        case missingURL
        case failedToDecodeFromData
    }

    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: configuration)
        return session
    }()

    private let source: ImageSource
    private var subscriptions: [AnyCancellable] = []
    private let cache = URLCache.shared

    private func loadFromCache(before request: URLRequest) throws -> UIImage? {
        cache.cachedResponse(for: request).flatMap { cached in
            UIImage(data: cached.data)
        }
    }

    private func cache(data: Data, for request: URLRequest, response: URLResponse) {
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: request)
    }
}
