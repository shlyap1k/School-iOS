//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct TabBar: View {
    // MARK: Internal

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ProductsListScreen()
            }
            .tabItem {
                Image(.catalog)
                    .renderingMode(.template)
                Text(L10n.TabView.productsScreen)
            }
            .tag(TabBarRoutes.catalog)
            
            NavigationStack {
                CartScreen()
            }
            .tabItem {
                Image(.cart)
                    .renderingMode(.template)
                Text(L10n.TabView.cartScreen)
            }
            .tag(TabBarRoutes.cart)
            
            NavigationStack {
                ProfileScreen()
            }
                .tabItem {
                    Image(.profile)
                        .renderingMode(.template)
                    Text(L10n.TabView.profileScreen)
                }
                .tag(TabBarRoutes.profile)
        }
    }

    // MARK: Private

    @State private var selectedTab: TabBarRoutes = .catalog
}

// #Preview {
//    TabBar()
// }
