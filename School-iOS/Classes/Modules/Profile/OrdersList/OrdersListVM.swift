//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation
import SwiftUI

class OrdersListVM: ObservableObject {
    // MARK: Internal

    static let dateFormatter = DateFormatter()

    @Published var orders: [Order] = []

    @Published var isLoading: Bool = false

    @Published var isEmpty: Bool = true

    @Published var placeholder: PlaceholderModel?

    var lastPageReached: Bool = false
    var page: Int = 0

    func fetchOrders() {
        isLoading = true
        let request = OrdersRequest.ordersList(pageNumber: page, pageSize: 15)

        Task {
            let result: RestResult<[Order]> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async { [weak self] in
                    if response.isEmpty {
                        self?.lastPageReached = true
                    } else {
                        self?.isEmpty = false
                    }

                    self?.orders += response

                    self?.placeholder = self?.orders.count == 0 ? .emptyOrders() : nil

                    self?.isLoading = false
                }
            case let .failure(reason):
                DispatchQueue.main.async { [weak weakSelf = self] in
                    guard let self = weakSelf else {
                        return
                    }
                    switch reason.detail {
                    case .noConnection:
                        weakSelf?.placeholder = .noConnection(isLoading: self.isLoadingBinding, action: {
                            weakSelf?.fetchOrders()
                        })
                    default:
                        weakSelf?.placeholder = .unknown(isLoading: self.isLoadingBinding, action: {
                            weakSelf?.fetchOrders()
                        })
                    }
                    weakSelf?.isLoading = false
                }
            }
        }
    }

    func nextPage() {
        guard !lastPageReached else {
            return
        }
        page += 1
        fetchOrders()
    }

    func dateFormat(date: Date) -> String {
        OrdersListVM.dateFormatter.dateStyle = .long
        OrdersListVM.dateFormatter.timeStyle = .short
        let formattedDate = OrdersListVM.dateFormatter.string(from: date)
        return formattedDate
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

            case .failure:
                return
            }
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider

    private var isLoadingBinding: Binding<Bool> {
        Binding<Bool>.init { [unowned self] in
            isLoading
        } set: { [unowned self] new in
            isLoading = new
        }
    }
}
