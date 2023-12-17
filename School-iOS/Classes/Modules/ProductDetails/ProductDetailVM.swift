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

    @Published var countSelectorModel: CountSelectorModel = .init()

    @Published var showAddToCart: Bool = false

    let product: Product

    var orderItem: OrderProduct? {
        guard let size = sizeSelectorModel.selectedSize?.value else {
            return nil
        }
        return OrderProduct(
            productId: product.id,
            preview: product.preview,
            title: product.title,
            size: size,
            quantity: countSelectorModel.count
        )
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

    // MARK: Private

    @Injected(\.appState) private var appState
}
