//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ProductsListScreen: View {
    @StateObject var viewModel: ProductsListVM = .init()

    var body: some View {
        VStack {
            if viewModel.isLoading, viewModel.products.isEmpty {
                LoaderView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.products) { product in
                            ProductItem(model: product)
                                .overlay(alignment: .bottom) {
                                    if product.id != viewModel.products.last?.id {
                                        Divider()
                                            .frame(width: 343)
                                    }
                                }
                                .onAppear {
                                    if product.id == viewModel.products.last?.id {
                                        viewModel.nextPage()
                                    }
                                }
                        }
                        if viewModel.isLoading {
                            LoaderView()
                        }
                    }
                    .padding(.bottom, 83)
                }
            }

        }.onAppear {
            viewModel.fetchProducts()
        }
        .navigationTitle(L10n.ProductsList.title)
    }
}

#Preview {
    NavigationStack {
        ProductsListScreen()
    }
}
