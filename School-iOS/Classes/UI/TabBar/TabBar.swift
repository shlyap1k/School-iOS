//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab: TabBarRoutes = .catalog
    
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
            Color.gray
                .tabItem {
                    Image(.cart)
                        .renderingMode(.template)
                    Text(L10n.TabView.cartScreen)
                }
                .tag(TabBarRoutes.cart)
            Text("Test")
                .tabItem {
                    Image(.profile)
                        .renderingMode(.template)
                    Text(L10n.TabView.profileScreen)
                }
                .tag(TabBarRoutes.profile)
        }
    }
}

#Preview {
    TabBar()
}
