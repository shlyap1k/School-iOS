//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct OrderCheckout: Encodable, Decodable {
    var house: String
    var apartment: String
    var dateDelivery: Date
    var products: [OrderProduct]
}
