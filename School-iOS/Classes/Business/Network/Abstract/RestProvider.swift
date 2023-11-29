//
// HH School
// Created by Shlyap1k.
//

import Foundation

protocol RestProvider: AnyObject {
    func make<T: Decodable>(_ request: Request, parameters: RestParameters) async -> RestResult<T>
}
