//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct AppState: Codable {
    struct Persistance {
        // MARK: Internal

        @UserDefaultValue(key: session) var accessToken: String?
        @UserDefaultValue(key: profileKey) var profile: Profile?

        func read() -> AppState {
            AppState(
                accessToken: accessToken,
                profile: profile
            )
        }

        mutating func write(_ appState: AppState) {
            accessToken = appState.accessToken
            profile = appState.profile
        }

        // MARK: Private

        private static let session = "hh-school.session"
        private static let profileKey = "hh-school.profile"
    }

    var accessToken: String?
    var profile: Profile?
}
