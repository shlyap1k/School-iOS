//
// HH School
// Created by Shlyap1k.
//

import Combine
import SwiftUI

struct CartScreen: View {
    @ObservedObject var viewModel: CartVM = .init()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ForEach($viewModel.cart.products, id: \.id) { $product in
                    CartItem(product: $product, removal: viewModel.removeProduct)
                        .onReceive(Just(product), perform: { product in
                            print(product.quantity)
                            viewModel.saveChanges(product: product) // TODO: save changes

                        })
                        .overlay(alignment: .bottom) {
                            if product.id != viewModel.cart.products.last?.id {
                                Divider()
                                    .padding([.leading, .trailing], 16)
                            }
                        }
                }
            }
        }
        .placeholder(viewModel.cart.products.isEmpty ? .emptyCart() : nil)
        .onAppear {
            viewModel.loadCart()
        }

        .navigationTitle(L10n.Cart.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !viewModel.cart.products.isEmpty {
                    Button(action: {
                        viewModel.clearCart()
                    }) {
                        Image(.delete)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CartScreen(viewModel: CartVM())
    }
}
