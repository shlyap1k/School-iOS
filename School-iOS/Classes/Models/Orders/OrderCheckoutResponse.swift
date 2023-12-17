//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct OrderCheckoutResponse: Decodable {
    let id: String
    let number: Int
    let createdDelivery: String
    let dateDelivery: String
    let deliveryAddress: String
    let status: String
    let products: [OrderProduct]
}
