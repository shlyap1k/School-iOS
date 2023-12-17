//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class CartVM: ObservableObject {
    // MARK: Internal

    @Published var cart: OrderCheckout = .init(house: "", apartment: "", dateDelivery: .now, products: [])

    @Published var productModels: [ProductDetailVM] = []

    @Published var houseModel: InputFieldModel = .init(text: "")

    @Published var apartmentModel: InputFieldModel = .init(text: "")

    @Published var deliveryDate: Date = .now

    @Published var isCompleted: Bool = false

    func unsetCheckoutCompleted() {
        appState.state.checkoutCompleted? = false
    }

    func clearCart() {
        cart.products = []
        appState.state.cart = cart
    }

    func loadIsCompleted() {
        if let isCompleted = appState.state.checkoutCompleted {
            self.isCompleted = isCompleted
        }
    }

    func loadCart() {
        if let cart = appState.state.cart {
            self.cart = cart
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
        }
    }

    // MARK: Private

    @Injected(\.appState) private var appState
}
