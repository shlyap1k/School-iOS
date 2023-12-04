//
// HH School
// Created by Shlyap1k.
//

import Factory
import netfox
import SwiftUI

@main
struct SchoolApp: App {
    // MARK: Lifecycle

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses?.insert(NFXProtocol.self, at: 0)
        NFX.sharedInstance().start()
    }

    // MARK: Internal

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch viewState {
                case .auth:
                    NavigationStack {
                        AuthScreen()
                    }
                case .list:
                    ProductsListScreen()
                    TabView {
                        NavigationStack {
                            ProductsListScreen()
                        }
                        .tabItem {
                            Image(.catalog)
                                .renderingMode(.template)
                            Text(L10n.TabView.productsScreen)
                        }
                        Color.gray
                            .tabItem {
                                Image(.cart)
                                    .renderingMode(.template)
                                Text(L10n.TabView.cartScreen)
                            }
                        Text("Test")
                            .tabItem {
                                Image(.profile)
                                    .renderingMode(.template)
                                Text(L10n.TabView.profileScreen)
                            }
                    }
                }
            }
            .animation(.linear, value: viewState)
            .onReceive(appState.published.receive(on: DispatchQueue.main)) { appState in
                let isAuthorized = appState.accessToken != nil
                let viewState: ViewState = isAuthorized ? .list : .auth
                if viewState != self.viewState {
                    self.viewState = viewState
                }
            }
        }
    }

    // MARK: Private

    private enum ViewState {
        case auth
        case list
    }

    @State private var viewState: ViewState = .auth

    @Injected(\.appState) private var appState
}

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}
