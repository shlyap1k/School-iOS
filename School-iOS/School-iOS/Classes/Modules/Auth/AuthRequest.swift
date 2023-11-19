//
//  AuthRequest.swift
//  School
//
//  Created by Heads and Handhs on 16.11.2023.
//

import Foundation

enum AuthRequest: Request {
    case auth(email: String, password: String)
    
    var authRequired: Bool? {
        false
    }
    
    var path: String {
        switch self {
        case .auth:
            return "user/signin"
        }
    }
    
    var method: RestMethod {
        .put
    }
    
    var body: Data? {
        switch self {
        case let .auth(email, password):
            return RequestDataEncoder.encode(
                AuthPayload(email: email, password: password)
            )
        }
    }
}
