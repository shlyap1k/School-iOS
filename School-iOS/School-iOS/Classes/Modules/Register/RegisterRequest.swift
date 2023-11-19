//
//  RegisterRequest.swift
//  School-iOS
//
//  Created by Shlyap1k on 19.11.2023.
//

import Foundation

enum RegisterRequest: Request {
    case register(avatarUrl: String, name: String, surname: String, occupation: String, email: String, password: String)
    
    var authRequired: Bool? {
        false
    }
    
    var path: String {
        switch self {
        case .register:
            return "user/registration"
        }
    }
    
    var method: RestMethod {
        .post
    }
    
    var body: Data? {
        switch self {
        case let .register(avatarUrl, name, surname, occupation, email, password):
            return RequestDataEncoder.encode(
                RegisterPayload(avatarUrl: avatarUrl, name: name, surname: surname, occupation: occupation, email: email, password: password)
            )
        }
    }
}
