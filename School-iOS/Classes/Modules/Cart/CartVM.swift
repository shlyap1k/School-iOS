//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class CartVM: ObservableObject {
    // MARK: Lifecycle

    init() {
        if let cart = appState.state.cart {
            self.cart = cart
        } else {
            placeholder = .emptyCart
        }
    }

    // MARK: Internal

    @Published var cart: OrderCheckout?

    @Published var productModels: [ProductDetailVM] = []

    @Published var houseModel: InputFieldModel = .init(text: "")

    @Published var apartmentModel: InputFieldModel = .init(text: "")

    @Published var deliveryDate: Date = .now

    @Published var placeholder: PlaceholderModel?

    func clearCart() {
        cart?.products = []
        appState.state.cart = nil
        placeholder = .emptyCart
    }

    func loadCart() {
        if let cart = appState.state.cart {
            self.cart = cart
            placeholder = nil
        }
    }

    // MARK: Private

    @Injected(\.appState) private var appState
}
