//
// HH School
// Created by Shlyap1k.
//

import Foundation

final class BaseAuthenticator: Authenticator {
    // MARK: Lifecycle

    init(
        authHeader: String,
        tokenType: String,
        accessTokenRetriever: @escaping () -> String?,
        expirationCheck: @escaping () -> Bool?
    ) {
        self.authHeader = authHeader
        self.tokenType = tokenType
        self.accessTokenRetriever = accessTokenRetriever
        self.expirationCheck = expirationCheck
    }

    // MARK: Internal

    func authenticate(_ request: inout URLRequest, checkAuthExpired: Bool) throws -> URLRequest {
        guard let accessToken = accessTokenRetriever() else {
            throw NetworkError(kind: .accessTokenLost)
        }
        guard !accessExpired(accessToken) || !checkAuthExpired else {
            throw NetworkError(kind: .authExpired)
        }
        request.setValue(tokenType + " " + accessToken, forHTTPHeaderField: authHeader)
        return request
    }

    func accessExpired(_ accessToken: String) -> Bool {
        if let expirationCheck = expirationCheck() {
            return expirationCheck
        } else {
            let jwtClaims = decode(jwtToken: accessToken)
            let timeInterval = jwtClaims["exp"] as? Int
            let expDate: Date? = timeInterval.map { Date(timeIntervalSince1970: TimeInterval($0)) }
            return expDate.map { Date.now >= $0 } ?? true
        }
    }

    // MARK: Private

    private let tokenType: String

    private let expirationCheck: () -> Bool?

    private let accessTokenRetriever: () -> String?

    private let authHeader: String

    private func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        if segments.count > 2 {
            return decodeJWTPart(segments[1]) ?? [:]
        } else {
            return [:]
        }
    }

    private func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 += padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    private func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []),
              let payload = json as? [String: Any]
        else {
            return nil
        }

        return payload
    }
}
