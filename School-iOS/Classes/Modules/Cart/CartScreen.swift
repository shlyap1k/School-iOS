//
// HH School
// Created by Shlyap1k.
//

import Combine
// import Factory
import SwiftUI

struct CartScreen: View {
    @StateObject var viewModel: CartVM = .init()

    @State var cart: OrderCheckout = .init(house: "", apartment: "", date: .now, products: [])

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ForEach($cart.products, id: \.id) { $product in
                    CartItem(product: $product)
                        .swipeActions {
                            Button("Burn") {
                                print("Right on!")
                            }
                            .tint(.red)
                        }
                        .onReceive(Just(product), perform: { product in
                            print(product.quantity) // TODO: save changes
                        })
                        .overlay(alignment: .bottom) {
                            if product.id != cart.products.last?.id {
                                Divider()
                                    .padding([.leading, .trailing], 16)
                            }
                        }
                }
            }
        }
        .onAppear {
            viewModel.loadCart()
            if let cart = viewModel.cart {
                self.cart = cart
            }
        }
        .placeholder(viewModel.placeholder)
        .navigationTitle("Корзина")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { viewModel.clearCart() }) {
                    Image(.delete)
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
