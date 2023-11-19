//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

protocol RequestBuilder: AnyObject {
    init(host: String, authenticator: Authenticator)
    func build(_ request: Request, checkAuthExpired: Bool) throws -> URLRequest
}
