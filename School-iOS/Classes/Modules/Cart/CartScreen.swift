//
// HH School
// Created by Shlyap1k.
//

import Combine
import SwiftUI

// MARK: - CartScreen

struct CartScreen: View {
    @StateObject var viewModel: CartVM = .init()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ForEach($viewModel.cart.products, id: \.id) { $product in
                    CartItemView(product: $product, removal: viewModel.removeProduct)
                        .onReceive(Just(product), perform: { product in
                            viewModel.saveChanges(product: product)

                        })
                        .overlay(alignment: .bottom) {
                            if product.id != viewModel.cart.products.last?.id {
                                Divider()
                                    .padding([.leading, .trailing], 16)
                            }
                        }
                }
                .padding(.bottom, 56 + 16)
            }
            .scrollIndicators(.hidden)
            if !viewModel.cart.products.isEmpty {
                NavigationLink(value: CartRoutes.checkout) {
                    StyledButton(title: L10n.Cart.checkout, style: .blue, action: {})
                        .allowsHitTesting(false)
                        .padding(16)
                }
            }
        }
        .placeholder(viewModel.cart.products.isEmpty ? .emptyCart() : nil)
        .onAppear {
            viewModel.loadCart()
        }
        .navigationDestination(for: CartRoutes.self, destination: { route in
            switch route {
            case .checkout:
                CheckoutScreen()
            case .cart:
                CartScreen()
            }
        })
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
