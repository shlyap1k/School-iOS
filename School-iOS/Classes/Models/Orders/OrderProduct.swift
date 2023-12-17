//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct OrderProduct: Codable, Identifiable {
    var id: UUID? = UUID()
    var productId: String
    var preview: String?
    var title: String?
    var size: String
    var quantity: Int
    var price: Double?
}
