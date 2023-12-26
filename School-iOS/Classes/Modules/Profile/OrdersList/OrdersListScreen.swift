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
                LazyVStack {
                    ForEach($viewModel.orders, id: \.id.self) { $order in
                        OrdersListItemView(order: $order, cancelOrder: viewModel.cancelOrder, dateFormat: viewModel.dateFormat)
                            .overlay(alignment: .bottom) {
                                if order.id != viewModel.orders.last?.id {
                                    Divider()
                                }
                            }
                    }
                    if let placeholder = viewModel.placeholder, !viewModel.orders.isEmpty {
                        PlaceholderView(model: placeholder)
                    }
                    if !viewModel.lastPageReached {
                        NextPageLoader(nextPage: viewModel.nextPage)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(16)
        .isLoading($viewModel.isLoading, $viewModel.isEmpty)
        .placeholder(viewModel.orders.isEmpty ? viewModel.placeholder : nil)
        .navigationTitle(L10n.OrdersList.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        OrdersListScreen()
    }
}
