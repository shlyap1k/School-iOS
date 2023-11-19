//
//  AuthPayload.swift
//  School
//
//  Created by Heads and Handhs on 16.11.2023.
//

import Foundation

struct AuthPayload: Encodable {
    let email: String
    let password: String
}
