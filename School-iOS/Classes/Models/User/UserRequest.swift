//
//  UserRequest.swift
//  School-iOS
//
//  Created by Shlyap1k on 21.11.2023.
//

import Foundation

enum UserRequest: Request {
    case fetchUser
    case updateUser(OperationType: Int, path: String, op: String, from: String, value: String)
    case uploadPhoto(photo: Data, uuid: String)
    case getPhoto(fileId: String)
    
    
    
    // MARK: Internal

    var authRequired: Bool? {
        true
    }
    
    var contentType: String {
        switch self {
        case let .uploadPhoto(_, uuid):
            return "multipart/form-data; boundary=\(uuid)"
        default:
            return "application/json"
        }
    }

    var path: String {
        switch self {
        case .fetchUser, .updateUser:
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
        case let .uploadPhoto(photo, uuid):
            
            let body = createBody(
                boundary: "\(uuid)",
                data: photo,
                mimeType: "image/png",
                filename: "avatar.png"
            )
            return body
        }
    }
}
