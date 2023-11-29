//
// HH School
// Created by Shlyap1k.
//

import Foundation

class ErrorRestResponseWrapper<T: Decodable>: AnyDecodableWrapper {
    // MARK: Lifecycle

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        wrapped = try container.decode(T.self, forKey: CodingKeys.wrapped)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case wrapped = "error"
    }

    private(set) var wrapped: T
}
