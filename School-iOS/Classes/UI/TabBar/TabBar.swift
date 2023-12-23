//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct TabBar: View {
    // MARK: Internal

    @StateObject var snackerModel: SnackerModel = .init()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ProductsListScreen(tabSelection: $selectedTab)
            }
            .environmentObject(snackerModel)
            .tabItem {
                Image(.catalog)
                    .renderingMode(.template)
                Text(L10n.TabView.productsScreen)
            }
            .tag(TabBarRoutes.catalog)

            NavigationStack {
                CartScreen()
            }
            .environmentObject(snackerModel)
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
        .overlay(alignment: .top) {
            if snackerModel.isPresented {
                SnackerView(model: snackerModel)
            }
        }
    }

    // MARK: Private

    @State private var selectedTab: TabBarRoutes = .catalog
}
