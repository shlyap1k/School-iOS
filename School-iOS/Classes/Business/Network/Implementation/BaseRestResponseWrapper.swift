//
// HH School
// Created by Shlyap1k.
//

import Foundation

class BaseRestResponseWrapper<T: Decodable>: AnyDecodableWrapper {
    // MARK: Lifecycle

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        wrapped = try container.decode(T.self, forKey: CodingKeys.wrapped)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case wrapped = "data"
    }

    private(set) var wrapped: T
}
