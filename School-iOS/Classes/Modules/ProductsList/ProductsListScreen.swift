//
//  ProductsListScreen.swift
//  School-iOS
//
//  Created by Shlyap1k on 29.11.2023.
//

import SwiftUI

struct ProductsListScreen: View {
    @StateObject var viewModel: ProductsListVM = .init()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoaderView()
            } else {
                ScrollView {
                    ForEach(viewModel.products) { product in
                        ProductItem(model: .constant(product))
                    }
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
