//
//  UpdateUserPayload.swift
//  School-iOS
//
//  Created by Shlyap1k on 21.11.2023.
//

import Foundation

// OperationType, path, op, from, value
struct UpdateUserPayload: Encodable {
    let OperationType: Int
    let path: String
    let op: String
    let from: String
    let value: String
}
