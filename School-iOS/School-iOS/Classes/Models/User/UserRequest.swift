//
//  UserRequest.swift
//  School-iOS
//
//  Created by Shlyap1k on 21.11.2023.
//

import Foundation

enum UserRequest {
    case fetchUser
    case updateUser(OperationType: Int, path: String, op: String, from: String, value: String)
    case uploadPhoto(photo: Data)
    case getPhoto(fileId: String)

    // MARK: Internal

    var authRequired: Bool? {
        true
    }

    var path: String {
        switch self {
        case .fetchUser:
            return "user"
        case .updateUser:
            return "user"
        case .uploadPhoto:
            return "user/photo"
        case let .getPhoto(fileId):
            return "user/photo/\(fileId)"
        }
    }

    var method: RestMethod {
        switch self {
        case .fetchUser, .getPhoto:
            .get
        case .updateUser:
            .patch
        case .uploadPhoto:
            .post
        }
    }

    var body: Data? {
        switch self {
        case .fetchUser, .getPhoto:
            return nil
        case let .updateUser(OperationType, path, op, from, value):
            return RequestDataEncoder.encode(
                UpdateUserPayload(OperationType: OperationType, path: path, op: op, from: from, value: value)
            )
        case let .uploadPhoto(photo):
            return RequestDataEncoder.encode(
                PhotoPayload(photo: photo)
            )
        }
    }
}
