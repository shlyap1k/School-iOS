//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class CartVM: ObservableObject {
    // MARK: Internal

    @Published var cart: OrderCheckout = .init(house: "", apartment: "", date: .now, products: [])

    @Published var productModels: [ProductDetailVM] = []

    @Published var houseModel: InputFieldModel = .init(text: "")

    @Published var apartmentModel: InputFieldModel = .init(text: "")

    @Published var deliveryDate: Date = .now

//    @Published var placeholder: PlaceholderModel? = .emptyCart()

    func clearCart() {
        cart.products = []
        appState.state.cart = cart
//        placeholder = .emptyCart()
    }

    func loadCart() {
        if let cart = appState.state.cart {
            self.cart = cart
//            if !cart.products.isEmpty {
//                placeholder = nil
//            }
        }
    }

    func saveChanges(product: OrderProduct) {
        if var cart = appState.state.cart, let index = cart.products.firstIndex(
            where: { $0.id == product.id }
        ) {
            cart.products[index] = product
            appState.state.cart = cart
        }
    }

    func removeProduct(product: OrderProduct) {
        if let cart = appState.state.cart, let index = cart.products.firstIndex(
            where: { $0.id == product.id }
        ) {
            self.cart.products.remove(
                at: index
            )
            appState.state.cart = self.cart

//            if self.cart.products.isEmpty {
//                placeholder = .emptyCart()
//            }
        }
    }

    // MARK: Private

    @Injected(\.appState) private var appState
}
