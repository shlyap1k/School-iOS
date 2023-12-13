//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class CheckoutFormVM: ObservableObject {
    // MARK: Internal

    @Published var house: InputFieldModel = .init(text: "")

    @Published var apartment: InputFieldModel = .init(text: "")

    @Published var deliveryDate: Date = .now

    @Published var isLoading: Bool = false

    @Published var orderCheckout: OrderCheckout = .init(
        house: "",
        apartment: "",
        dateDelivery: .now,
        products: []
    )

    func loadCart() {
        if let cart = appState.state.cart {
            orderCheckout = cart
        }
    }

    func resetCart() {
        orderCheckout.products = []
        appState.state.cart = orderCheckout
    }

    func checkout(onComplete: (() -> Void)?) {
        orderCheckout.apartment = apartment.text
        orderCheckout.house = house.text
        orderCheckout.dateDelivery = deliveryDate
        let request = OrdersRequest.checkout(order: orderCheckout)
        isLoading = true
        Task {
            let result: RestResult<OrderCheckoutResponse> = await restProvider.make(request)
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.resetCart()
                    self.isLoading = false
                    self.appState.state.checkoutCompleted = true
                    onComplete?()
                }
            case let .failure(reason):
                DispatchQueue.main.async {
                    self.apartment.error = reason.detail.message
                    self.isLoading = false
                }
            }
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
