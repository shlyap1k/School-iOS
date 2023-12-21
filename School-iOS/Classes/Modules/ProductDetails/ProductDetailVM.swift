//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation
import SwiftUI

class ProductDetailVM: ObservableObject {
    // MARK: Lifecycle

    init(product: Product) {
        self.product = product
        imagesSliderModel = .init(images: product.images.map { ImageModel(url: $0) })
        sizeSelectorModel = .init(sizes: product.sizes)
    }

    // MARK: Internal

    @Published var imagesSliderModel: ImagesSliderModel

    @Published var sizeSelectorModel: SizeSelectorModel

//    @Published var countSelectorModel: CountSelectorModel = .init()
    @Published var count: Int = 1

    @Published var showGoToCart: Bool = false

    @Published var showError: Bool = false

    let product: Product

    let order_id: UUID = .init()

    var orderItem: OrderProduct? {
        guard let size = sizeSelectorModel.selectedSize?.value else {
            return nil
        }
        return OrderProduct(
            id: order_id,
            productId: product.id,
            preview: product.preview,
            title: product.title,
            size: size,
            quantity: count
        )
    }

    func goToCart(tabSelection: inout TabBarRoutes) {
        tabSelection = .cart
    }

    func addToCart() {
        if var cart = appState.state.cart, let orderItem {
            cart.products.append(orderItem)
            appState.state.cart = cart
        } else {
            appState.state.cart = .init(
                house: "",
                apartment: "",
                dateDelivery: .now,
                products: []
            )
            addToCart()
        }
    }

    func saveCount() {
        if var cart = appState.state.cart, let orderItem, let index = cart.products.firstIndex(
            where: { $0.id == orderItem.id }
        ) {
            cart.products[index] = orderItem
            appState.state.cart = cart
        }
    }

    // MARK: Private

    @Injected(\.appState) private var appState
}
