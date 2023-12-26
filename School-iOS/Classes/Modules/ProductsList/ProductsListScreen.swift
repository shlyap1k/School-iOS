//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ProductsListScreen: View {
    @StateObject var viewModel: ProductsListVM = .init()

    @Binding var tabSelection: TabBarRoutes

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.products, id: \.self) { product in
                        NavigationLink(value: ProductsListRoutes.product(product)) {
                            ProductItemView(model: product)
                                .overlay(alignment: .bottom) {
                                    if product.id != viewModel.products.last?.id {
                                        Divider()
                                            .padding(.leading, 19)
                                            .padding(.trailing, 13)
                                    }
                                }
                                .applyStyle(.bold16)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    if let placeholder = viewModel.placeholder, !viewModel.products.isEmpty {
                        PlaceholderView(model: placeholder)
                    }
                    if !viewModel.lastPageReached {
                        NextPageLoader(nextPage: viewModel.nextPage)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .isLoading($viewModel.isLoading, $viewModel.isEmpty)
        .placeholder(viewModel.products.isEmpty ? viewModel.placeholder : nil)
        .navigationTitle(L10n.ProductsList.title)
        .navigationDestination(for: ProductsListRoutes.self, destination: { route in
            switch route {
            case let .product(product):
                if let product {
                    ProductDetailScreen(
                        tabSelection: $tabSelection,
                        viewModel: ProductDetailVM(product: product)
                    )
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        ProductsListScreen(tabSelection: .constant(TabBarRoutes.catalog))
    }
}
