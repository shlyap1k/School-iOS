//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

protocol RestProvider: AnyObject {
    func make<T: Decodable>(_ request: Request, parameters: RestParameters) async -> RestResult<T>
}
