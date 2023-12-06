//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
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

#Preview {
    TabBar()
}
