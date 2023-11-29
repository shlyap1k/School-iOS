//
// HH School
// Created by Shlyap1k.
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
