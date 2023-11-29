//
// HH School
// Created by Shlyap1k.
//

import Foundation

protocol Authenticator: AnyObject {
    init(
        authHeader: String,
        tokenType: String,
        accessTokenRetriever: @escaping () -> String?,
        expirationCheck: @escaping () -> Bool?
    )
    func accessExpired(_ accessToken: String) -> Bool
    func authenticate(_ urlRequest: inout URLRequest, checkAuthExpired: Bool) throws -> URLRequest
}
