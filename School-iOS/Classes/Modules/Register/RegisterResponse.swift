//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct RegisterResponse: Decodable {
    let accessToken: String
    let profile: Profile
}
