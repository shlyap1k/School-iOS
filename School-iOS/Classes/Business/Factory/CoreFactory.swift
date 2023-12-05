//
// HH School
// Created by Shlyap1k.
//

import Combine
import Factory
import Foundation

extension Container {
    var restProvider: Factory<RestProvider> {
        Factory(self) {
            let appState: Store<AppState> = Container.shared.appState.resolve()
            let authenticator: Authenticator = BaseAuthenticator(
                authHeader: "Authorization",
                tokenType: "Bearer",
                accessTokenRetriever: {
                    appState[\.accessToken]
                },
                expirationCheck: {
                    appState[\.accessToken].map(\.isEmpty)
                }
            )
            let requestBuilder: RequestBuilder = BaseRequestBuilder(
                host: "http://45.144.64.179/cowboys/api",
                authenticator: authenticator
            )
            return BaseRestProvider(
                requestBuilder: requestBuilder,
                decoder: JSONDecoder(),
                refresher: nil
            )
        }
    }

    private static var appStateSubsciption: AnyCancellable?

    var appState: Factory<Store<AppState>> {
        Factory(self) {
            var persistance = AppState.Persistance()
            let appState = Store<AppState>(initial: persistance.read())
            Self.appStateSubsciption = appState.published.sink { state in
                persistance.write(state)
            }
            return appState
        }.singleton
    }
}
