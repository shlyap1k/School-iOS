import Foundation

struct AppState: Codable {
    struct Persistance {
        // MARK: Internal

        @UserDefaultValue(key: session) var accessToken: String?

        func read() -> AppState {
            AppState(
                accessToken: accessToken
            )
        }

        mutating func write(_ appState: AppState) {
            accessToken = appState.accessToken
        }

        // MARK: Private

        private static let session = "hh-school.session"
    }

    var accessToken: String?
}
