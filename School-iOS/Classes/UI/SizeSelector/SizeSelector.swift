//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct SizeSelector: View {
    @ObservedObject var selectorModel: SizeSelectorModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(L10n.ProductDetails.size)
                .applyStyle(.bold14)
            HStack(spacing: 8) {
                ForEach(selectorModel.sizes, id: \.self) { size in
                    SizeItem(selectedSize: $selectorModel.selectedSize, size: size)
                }
            }
        }
    }
}

#Preview {
    SizeSelector(
        selectorModel: SizeSelectorModel(
            sizes: [
                Size(value: "M", isAvailable: true),
                Size(value: "L", isAvailable: false),
                Size(value: "X", isAvailable: true),
            ]
        )
    )
}
