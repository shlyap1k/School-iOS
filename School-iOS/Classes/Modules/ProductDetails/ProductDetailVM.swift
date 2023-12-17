//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

class ProductDetailVM: ObservableObject {
    // MARK: Lifecycle

    init(product: Product) {
        self.product = product
        imagesSliderModel = .init(images: product.images.map { ImageModel(url: $0) } )
        sizeSelectorModel = .init(sizes: product.sizes)
    }

    // MARK: Internal

    @Published var imagesSliderModel: ImagesSliderModel

    @Published var sizeSelectorModel: SizeSelectorModel

    @Published var countSelectorModel: CountSelectorModel = .init()

    @Published var addToCart: Bool = false

    let product: Product
}
