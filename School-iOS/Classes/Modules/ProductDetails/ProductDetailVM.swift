//
//  ProductDetailVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import Foundation
import SwiftUI

class ProductDetailVM: ObservableObject {
    @Published var imagesSliderModel: ImagesSliderModel
    
    @Published var sizeSelectorModel: SizeSelectorModel
    
    @Published var countSelectorModel: CountSelectorModel = .init()
    
    @Published var addToCart: Bool = false
    
    let product: Product
    
    init(product: Product) {
        self.product = product
        self.imagesSliderModel = .init(images: product.images)
        self.sizeSelectorModel = .init(sizes: product.sizes)
    }
}
