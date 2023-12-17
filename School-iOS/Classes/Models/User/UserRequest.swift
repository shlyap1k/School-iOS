//
// HH School
// Created by Shlyap1k.
//

import Foundation

enum UserRequest: Request {
    case fetchUser
    case updateUser(updateUserPayload: [UpdateUserPayload])
    case uploadPhoto(photo: Data, uuid: String)
    case getPhoto(fileId: String)

    // MARK: Internal

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
        case let .updateUser(updateUserPayload):
            return RequestDataEncoder.encode(updateUserPayload)
        case let .uploadPhoto(photo, uuid):
            return RequestDataEncoder.multipartPayload(
                boundary: String(uuid),
                data: photo,
                mimeType: "image/png",
                filename: "avatar.png"
            )
        }
    }
}
