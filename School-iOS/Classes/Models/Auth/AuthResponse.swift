//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct AuthResponse: Decodable {
    let accessToken: String
    let profile: Profile
}
