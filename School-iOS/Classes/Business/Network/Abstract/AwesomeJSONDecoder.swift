//
// HH School
// Created by Shlyap1k.
//

import Foundation

// MARK: - AwesomeJSONDecoder

final class AwesomeJSONDecoder: JSONDecoder {
    // MARK: Lifecycle

    override init() {
        super.init()
        dateDecodingStrategy = .iso8601
    }

    // MARK: Internal

    override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            return try super.decode(type, from: data)
        } catch let error as NSError {
            switch error {
            case let decodeError as DecodingError:
                let errorDescription: String
                let path: (DecodingError.Context) -> String = { context in
                    context.codingPath.map(\.stringValue).joined(separator: ".")
                }
                switch decodeError {
                case let .typeMismatch(type, context):
                    errorDescription = "Type \(type) mismatch \(context.debugDescription); coding path \(path(context))"
                case let .valueNotFound(type, context):
                    errorDescription =
                        "Value of type \(type) not found \(context.debugDescription); coding path \(path(context))"
                case let .keyNotFound(key, context):
                    errorDescription = "Key \(key) not found \(context.debugDescription); coding path \(path(context))"
                case let .dataCorrupted(context):
                    errorDescription = "Data corrupted; coding path \(path(context))"
                default:
                    errorDescription = "unknown decoding error"
                }
                debugPrint(errorDescription)
            default:
                break
            }
            throw error
        }
    }
}
