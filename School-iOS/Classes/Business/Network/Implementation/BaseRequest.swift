//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct BaseRequest: Request {
    // MARK: Lifecycle

    init(
        urlParameters: [URLQueryItem]? = nil,
        authRequired: Bool? = true,
        path: String,
        method: RestMethod = .get,
        additionalHeaders: [String: String] = [:],
        body: Data? = nil
    ) {
        self.urlParameters = urlParameters
        self.authRequired = authRequired
        self.path = path
        self.method = method
        self.additionalHeaders = additionalHeaders
        self.body = body
    }

    // MARK: Internal

    static let stub = BaseRequest(path: "")

    let urlParameters: [URLQueryItem]?
    let authRequired: Bool?
    let path: String
    let method: RestMethod
    let additionalHeaders: [String: String]
    let body: Data?
}
