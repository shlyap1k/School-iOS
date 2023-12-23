//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct AppState: Codable {
    struct Persistance {
        // MARK: Internal

        @KeychainValue(key: session) var accessToken: String?
        @UserDefaultValue(key: profileKey) var profile: Profile?
        @UserDefaultValue(key: cart) var cart: OrderCheckout?

        func read() -> AppState {
            AppState(
                accessToken: accessToken,
                profile: profile,
                cart: cart
            )
        }

        mutating func write(_ appState: AppState) {
            accessToken = appState.accessToken
            profile = appState.profile
            cart = appState.cart
        }

        // MARK: Private

        private static let session = "hh-school.session"
        private static let profileKey = "hh-school.profile"
        private static let cart = "hh-school.cart"
    }

    var accessToken: String?
    var profile: Profile?
    var cart: OrderCheckout?
}
