//
//  RegisterPayload.swift
//  School-iOS
//
//  Created by Shlyap1k on 19.11.2023.
//

import Foundation

struct RegisterPayload: Encodable {
    let avatarUrl: String
    let name: String
    let surname: String
    let occupation: String
    let email: String
    let password: String
}
