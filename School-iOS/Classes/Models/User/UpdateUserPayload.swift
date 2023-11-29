//
// HH School
// Created by Shlyap1k.
//

import Foundation

// OperationType, path, op, from, value
struct UpdateUserPayload: Encodable {
    let operationType: Int
    let path: String
    let op: String
    let from: String
    let value: String
}
