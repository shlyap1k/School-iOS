//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ProductsListScreen: View {
    @StateObject var viewModel: ProductsListVM = .init()

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.products, id: \.self) { product in
                        NavigationLink(value: ProductsListRoutes.product(product)) {
                            ProductItem(model: product)
                                .overlay(alignment: .bottom) {
                                    if product.id != viewModel.products.last?.id {
                                        Divider()
                                            .padding([.leading, .trailing], 16)
                                    }
                                }
                                .applyStyle(.bold16)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    if !viewModel.lastPageReached {
                        NextPageLoader(nextPage: viewModel.nextPage)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .isLoading($viewModel.isLoading, $viewModel.isEmpty)
        .placeholder(viewModel.placeholder)
        .navigationTitle(L10n.ProductsList.title)
        .navigationDestination(for: ProductsListRoutes.self, destination: { route in
            switch route {
            case let .product(product):
                if let product {
                    Text(product.title)
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        ProductsListScreen()
    }
}
