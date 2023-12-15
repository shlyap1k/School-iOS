//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct OrdersListScreen: View {
    @StateObject var viewModel: OrdersListVM = .init()

    var body: some View {
        VStack {
            ScrollView {
                ForEach($viewModel.orders, id: \.id.self) { $order in
                    OrdersListItem(order: $order, cancelOrder: viewModel.cancelOrder, dateFormat: viewModel.dateFormat)
                        .overlay(alignment: .bottom) {
                            if order.id != viewModel.orders.last?.id {
                                Divider()
                            }
                        }
                }
            }
        }
        .padding(16)
        .navigationTitle(L10n.OrdersList.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchOrders()
        }
    }
}

#Preview {
    NavigationStack {
        OrdersListScreen()
    }
}
