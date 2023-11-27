//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

enum RequestDataEncoder {
    static func encode(
        _ data: some Encodable,
        encoderKeyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys,
        encoderDateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601
    ) -> Data? {
        if let json = data as? [String: Any] {
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        } else {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = encoderKeyEncodingStrategy
            encoder.dateEncodingStrategy = encoderDateEncodingStrategy
            return try? encoder.encode(data)
        }
    }
}
