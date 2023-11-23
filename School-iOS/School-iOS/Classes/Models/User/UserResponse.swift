//
//  UserResponse.swift
//  School-iOS
//
//  Created by Shlyap1k on 21.11.2023.
//

import Foundation

struct UserResponse: Decodable {
    var name: String
    var surname: String
    var occupation: String
    var avatarId: String
}
