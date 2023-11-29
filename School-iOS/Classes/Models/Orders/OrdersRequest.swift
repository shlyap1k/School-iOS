//
// HH School
// Created by Shlyap1k.
//

import Foundation

enum OrdersRequest: Request {
    case checkout(order: OrderCheckout)
    case ordersList(pageNumber: Int, pageSize: Int)
    case cancelOrder(orderId: String)

    // MARK: Internal

    var path: String {
        switch self {
        case .checkout:
            return "orders/checkout"
        case .ordersList:
            return "orders"
        case let .cancelOrder(orderId):
            return "orders/\(orderId)"
        }
    }

    var method: RestMethod {
        switch self {
        case .checkout:
            return .post
        case .ordersList:
            return .get
        case .cancelOrder:
            return .put
        }
    }

    var body: Data? {
        switch self {
        case let .checkout(order: order):
            return RequestDataEncoder.encode(
                order
            )
        case .ordersList, .cancelOrder:
            return nil
        }
    }

    var urlParameters: [URLQueryItem]? {
        switch self {
        case let .ordersList(pageNumber, pageSize):
            return [
                URLQueryItem(name: "pageNumber", value: "\(pageNumber)"),
                URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            ]
        case .checkout, .cancelOrder:
            return nil
        }
    }
}
