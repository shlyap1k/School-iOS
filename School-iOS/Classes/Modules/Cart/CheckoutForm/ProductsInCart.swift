//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct ProductsInCart: View {
    var products: OrderCheckout

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(products.products, id: \.id) { product in
                HStack(alignment: .top, spacing: 16) {
                    if let preview = product.preview {
                        AsyncImage(url: URL(string: preview)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                        } placeholder: {
                            LoaderView()
                                .frame(width: 64, height: 64, alignment: .center)
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        if let title = product.title {
                            Text(title)
                                .applyStyle(.bold16)
                                .lineLimit(1)
                        }
                        Text("\(L10n.CartCheckout.size) \(product.size), \(product.quantity) \(L10n.CartCheckout.count)")
                    }
                }
                .padding(.bottom, 8)
                .overlay(alignment: .bottom) {
                    if product.id != products.products.last?.id {
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    ProductsInCart(
        products:
        OrderCheckout(
            house: "",
            apartment: "",
            dateDelivery: .now,
            products: [
                OrderProduct(
                    id: UUID(),
                    productId: "aboba",
                    preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                    title: "one product with long title and this title is too big to be displayed fully",
                    size: "M",
                    quantity: 5
                ),
                OrderProduct(
                    id: UUID(),
                    productId: "aboba",
                    preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                    title: "second product with long title and this title is too big to be displayed fully",
                    size: "M",
                    quantity: 15
                ),
                OrderProduct(
                    id: UUID(),
                    productId: "aboba",
                    preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                    title: "third",
                    size: "M",
                    quantity: 3
                ),
            ]
        )
    )
}
