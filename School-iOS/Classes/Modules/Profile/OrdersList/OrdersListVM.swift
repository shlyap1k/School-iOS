//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class OrdersListVM: ObservableObject {
    // MARK: Internal

    @Published var orders: [Order] = []

    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        let formattedDate = dateFormatter.string(from: date)

        return formattedDate
    }

    func fetchOrders() {
        let request = OrdersRequest.ordersList(pageNumber: 1, pageSize: 15)
        Task {
            let result: RestResult<[Order]> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.orders = response
                }
            case let .failure(error):
                print(error.detail.message)
            }
        }
    }

    func cancelOrder(order: Order) {
        let request = OrdersRequest.cancelOrder(orderId: order.id)
        Task {
            let result: RestResult<Order> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    if let orderIndex = self.orders.firstIndex(where: { $0.id == response.id }) {
                        self.orders[orderIndex] = response
                    }
                }

            case let .failure(error):
                print(error.detail.message)
            }
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
}
