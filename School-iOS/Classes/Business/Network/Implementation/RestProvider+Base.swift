//
// HH School
// Created by Shlyap1k.
//

import Foundation

extension RestProvider {
    func make<T: Decodable>(_ request: Request, parameters: RestParameters = .base(wrapped: T.self)) async -> RestResult<T> {
        await make(request, parameters: parameters)
    }
}
