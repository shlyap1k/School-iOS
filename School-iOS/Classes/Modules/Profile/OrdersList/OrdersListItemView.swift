//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct OrdersListItemView: View {
    // MARK: Internal

    @Binding var order: Order

    var cancelOrder: (Order) -> Void

    var dateFormat: (Date) -> String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(L10n.OrdersList.order) \(order.id)")
                .applyStyle(.bold16)
                .lineLimit(1)

            switch order.status {
            case .inWork:
                if let dateDelivery = order.dateDelivery {
                    Text("\(L10n.OrdersList.delivery) \(dateFormat(dateDelivery))")
                }
            case .cancelled:
                Text(L10n.OrdersList.cancelled)
            default:
                EmptyView()
            }

            Text("\(order.deliveryAddress)")

            HStack {
                HStack(spacing: -22) {
                    if !order.products.isEmpty {
                        ForEach(order.products[0 ... min(3, order.products.count - 1)]) { product in
                            if let preview = product.preview {
                                LoadImage(imageUrl: preview)
                                    .frame(width: 44, height: 44)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .foregroundStyle(.white)
                                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    )
                            }
                        }
                    }

                    if order.products.count >= 5 {
                        Text("\(order.products.count)")
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .foregroundStyle(Assets.backgroundBlack.swiftUIColor)
                                    .frame(width: 44, height: 44)
                            )
                            .padding(.leading, 11)
                    }
                }

                Spacer()

                switch order.status {
                case .inWork:
                    StyledButton(title: L10n.OrdersList.cancelDelivery, style: .redSmall) {
                        isPresented.toggle()
                    }
                    .frame(width: 120)
                default:
                    EmptyView()
                }
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 20)
        .confirmationDialog("", isPresented: $isPresented, actions: {
            Button(L10n.OrdersList.cancelYes, role: .destructive) {
                cancelOrder(order)
            }
            Button(L10n.OrdersList.cancelNo, role: .cancel) {
                isPresented = false
            }
        }, message: {
            Text("\(L10n.OrdersList.cancelConfirm) \(order.id)?")
        })
    }

    // MARK: Private

    @State private var isPresented: Bool = false
}

#Preview {
    OrdersListItemView(
        order: .constant(
            .init(
                id: "1d2b7c22-7692-418c-9d9d-98c7db686b6e",
                number: 3,
                createdDelivery: .now,
                dateDelivery: .now,
                deliveryAddress: "string, string",
                status: OrderStatus(rawValue: "in_work"),
                products: [
                    .init(
                        productId: "061f02a0-8d12-4828-ab33-6b319a367e66",
                        preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                        title: "title",
                        size: "M",
                        quantity: 5,
                        price: 9000.0
                    ),
                    .init(
                        productId: "061f02a0-8d12-4828-ab33-6b319a367e64",
                        preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                        title: "title",
                        size: "M",
                        quantity: 5,
                        price: 9000.0
                    ),
                    .init(
                        productId: "061f02a0-8d12-4828-ab33-6b319a367e63",
                        preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                        title: "title",
                        size: "M",
                        quantity: 5,
                        price: 9000.0
                    ),
                    .init(
                        productId: "061f02a0-8d12-4828-ab33-6b319a367e63",
                        preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                        title: "title",
                        size: "M",
                        quantity: 5,
                        price: 9000.0
                    ),
                    .init(
                        productId: "061f02a0-8d12-4828-ab33-6b319a367e63",
                        preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                        title: "title",
                        size: "M",
                        quantity: 5,
                        price: 9000.0
                    ),
                    .init(
                        productId: "061f02a0-8d12-4828-ab33-6b319a367e63",
                        preview: "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3533000/ff_3533150-d9254664c08370f8572c_full.jpg&w=340",
                        title: "title",
                        size: "M",
                        quantity: 5,
                        price: 9000.0
                    ),
                ]
            )
        ), cancelOrder: { _ in }, dateFormat: OrdersListVM().dateFormat
    )
}
