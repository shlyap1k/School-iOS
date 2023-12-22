//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class CheckoutFormVM: ObservableObject {
    // MARK: Internal

    @Published var houseModel: InputFieldModel = .init(text: "")

    @Published var apartmentModel: InputFieldModel = .init(text: "")

    @Published var deliveryDate: Date = .now

    @Published var isLoading: Bool = false

    @Published var orderCheckout: OrderCheckout = .init(
        house: "",
        apartment: "",
        dateDelivery: .now,
        products: []
    )

    func validate() -> Bool {
        var isValid = true

        if !Validator.validate(.requiredField, value: houseModel.text) {
            isValid = false
            houseModel.error = L10n.Validation.requiredFieldError
        } else {
            houseModel.error = nil
        }

        if !Validator.validate(.requiredField, value: apartmentModel.text) {
            isValid = false
            apartmentModel.error = L10n.Validation.requiredFieldError
        } else {
            apartmentModel.error = nil
        }

        return isValid
    }

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
        guard validate() else {
            return
        }
        orderCheckout.apartment = apartmentModel.text
        orderCheckout.house = houseModel.text
        orderCheckout.dateDelivery = deliveryDate
        let request = OrdersRequest.checkout(order: orderCheckout)
        isLoading = true
        Task {
            let result: RestResult<OrderCheckoutResponse> = await restProvider.make(request)
            switch result {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.resetCart()
                    self?.isLoading = false
                    self?.appState.state.checkoutCompleted = true
                    onComplete?()
                }
            case let .failure(reason):
                DispatchQueue.main.async { [weak self] in
                    self?.apartmentModel.error = reason.detail.message
                    self?.isLoading = false
                }
            }
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
