//
// HH School
// Created by Shlyap1k.
//

import Foundation

// MARK: - RestConfiguration

struct RestConfiguration {
    // MARK: Lifecycle

    init(
        apiUrl: String,
        authHeader: String = "Authorization",
        tokenType: String = "Bearer",
        accessTokenRetriever: @escaping () -> String?,
        expirationCheck: @escaping () -> Bool?,
        refresher: Refresher?,
        decoder: JSONDecoder = AwesomeJSONDecoder()
    ) {
        self.apiUrl = apiUrl
        self.authHeader = authHeader
        self.tokenType = tokenType
        self.accessTokenRetriever = accessTokenRetriever
        self.expirationCheck = expirationCheck
        self.refresher = refresher
        self.decoder = decoder
    }

    // MARK: Internal

    let apiUrl: String
    let authHeader: String
    let tokenType: String
    let accessTokenRetriever: () -> String?
    let expirationCheck: () -> Bool? // detects if access has been expired
    let refresher: Refresher?
    let decoder: JSONDecoder
}
