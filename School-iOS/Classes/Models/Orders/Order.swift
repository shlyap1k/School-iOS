//
// HH School
// Created by Shlyap1k.
//

import Foundation

// MARK: - Order

struct Order: Decodable {
    var id: String
    var number: Int
    var createdDelivery: Date
    var dateDelivery: Date?
    var deliveryAddress: String
    var status: String
    var products: [OrderProduct]
}
