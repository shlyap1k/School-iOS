//
// HH School
// Created by Shlyap1k.
//

import Foundation

enum NetworkErrorKind: Error {
    case accessTokenLost
    case invalidHost
    case invalidUrlComponents
    case urlComponentsAppendError
    case decode
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case authExpired
    case refresherInjectError
    case noRefreshStrategy
    case noRefreshResponseWrapper
    case noMockData
    case unknown
    case regularNetworkError
    case system(URLError)
}
