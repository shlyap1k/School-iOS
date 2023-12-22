//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct CartItemView: View {
    @Binding var product: OrderProduct

    @State var offset = CGSize.zero

    var removal: (OrderProduct) -> Void

    var body: some View {
        ZStack(alignment: .trailing) {
            StyledButton(icon: Image(.delete), style: .redBig) {
                removal(product)
            }
            .frame(width: 60)

            HStack(alignment: .top, spacing: 0) {
                if let preview = product.preview {
                    LoadImage(imageUrl: preview)
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
            .background(.white)
            .offset(x: offset.width, y: 0)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if (-80 ... 0).contains(gesture.translation.width) {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if offset.width <= -65 {
                            removal(product)
                        } else if abs(offset.width) >= 40 {
                            offset.width = -80
                        } else {
                            offset.width = 0
                        }
                    }
            )
            .gesture(
                TapGesture()
                    .onEnded {
                        offset = .zero
                    }
            )
        }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 18)
    }
}

#Preview {
    CartItemView(product: .constant(OrderProduct(
        productId: "aboba",
        preview: "https://www.recordnet.com/gcdn/presto/2021/03/22/NRCD/9d9dd9e4-e84a-402e-ba8f-daa659e6e6c5-PhotoWord_003.JPG?width=660&height=425&fit=crop&format=pjpg&auto=webp",
        title: "Preview product",
        size: "M",
        quantity: 3
    )), removal: { _ in

    })
}
