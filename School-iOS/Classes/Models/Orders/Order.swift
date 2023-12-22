//
// HH School
// Created by Shlyap1k.
//

import Foundation

// MARK: - Order

struct Order: Decodable {
    let id: String
    let number: Int
    let createdDelivery: Date
    let dateDelivery: Date?
    let deliveryAddress: String
    let status: OrderStatus
    let products: [OrderProduct]
}
