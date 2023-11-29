//
// HH School
// Created by Shlyap1k.
//

import Foundation

final class BaseRequestBuilder: RequestBuilder {
    // MARK: Lifecycle

    init(host: String, authenticator: Authenticator) {
        self.host = host
        self.authenticator = authenticator
    }

    // MARK: Internal

    func build(_ request: Request, checkAuthExpired: Bool) throws -> URLRequest {
        guard let baseURL = URL(string: "\(host)/") else {
            throw NetworkError(kind: .invalidHost)
        }
        var url = baseURL.appendingPathComponent(request.path)
        if let urlParams = request.urlParameters, !urlParams.isEmpty {
            url = try append(to: url, urlParams)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue.uppercased()
        urlRequest.httpBody = request.body
        request.regularHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        request.additionalHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if let authRequired = request.authRequired {
            return authRequired
                ? try authenticator
                    .authenticate(&urlRequest, checkAuthExpired: checkAuthExpired)
                : urlRequest
        } else {
            let authenticatedUrlRequest = try? authenticator
                .authenticate(&urlRequest, checkAuthExpired: checkAuthExpired)
            return authenticatedUrlRequest ?? urlRequest
        }
    }

    // MARK: Private

    private let authenticator: Authenticator

    private let host: String

    private func prefixHTTPs(_ url: String) -> String {
        let prefix = "https://"
        return url.contains(prefix) ? url : prefix + url
    }

    private func append(to url: URL, _ queryItems: [URLQueryItem]) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkError(kind: .invalidUrlComponents)
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        if let url = urlComponents.url {
            return url
        } else {
            throw NetworkError(kind: .urlComponentsAppendError)
        }
    }
}
