//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

extension RestProvider {
    func make<T: Decodable>(_ request: Request, parameters: RestParameters = .base(wrapped: T.self)) async -> RestResult<T> {
        await make(request, parameters: parameters)
    }
}
