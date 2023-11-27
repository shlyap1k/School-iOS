//
// HH School
// Created by Shlyap1k.
//

import Foundation

enum AuthRequest: Request {
    case auth(email: String, password: String)
    case register(
        avatarUrl: String?,
        name: String,
        surname: String,
        occupation: String,
        email: String,
        password: String
    )

    // MARK: Internal

    var authRequired: Bool? {
        false
    }

    var path: String {
        switch self {
        case .auth:
            return "user/signin"
        case .register:
            return "user/register"
        }
    }

    var method: RestMethod {
        switch self {
        case .auth:
            return .put
        case .register:
            return .post
        }
    }

    var body: Data? {
        switch self {
        case let .auth(email, password):
            return RequestDataEncoder.encode(
                AuthPayload(email: email, password: password)
            )
        case let .register(avatarUrl, name, surname, occupation, email, password):
            return RequestDataEncoder.encode(
                RegisterPayload(
                    avatarUrl: avatarUrl ?? "",
                    name: name,
                    surname: surname,
                    occupation: occupation,
                    email: email,
                    password: password
                )
            )
        }
    }
}
