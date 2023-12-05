//
// HH School
// Created by Shlyap1k.
//

import Foundation

protocol RequestBuilder: AnyObject {
    init(host: String, authenticator: Authenticator)
    func build(_ request: Request, checkAuthExpired: Bool) throws -> URLRequest
}
