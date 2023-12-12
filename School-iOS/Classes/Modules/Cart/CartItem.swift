//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct CartItem: View {
    @Binding var product: OrderProduct

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if let preview = product.preview {
                AsyncImage(url: URL(string: preview)) {
                    image in
                    image.resizable()
                } placeholder: {
                    LoaderView()
                }
                .frame(width: 116, height: 116)
                .padding(.trailing, 18)
            }

            VStack(alignment: .leading, spacing: 0) {
                if let title = product.title {
                    Text(title)
                        .lineLimit(3)
                        .applyStyle(.bold16)

                    Spacer(minLength: 4)
                }

                HStack(spacing: 16) {
                    SizeItem(
                        selectedSize: .constant(nil),
                        size: Size(value: product.size, isAvailable: true)
                    )

                    CountSelector(count: $product.quantity, style: .small)
                }
            }
            .frame(height: 116)
        }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 18)
    }
}

// #Preview {
//
// }
