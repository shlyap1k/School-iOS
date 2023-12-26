//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct OrderProduct: Codable, Identifiable {
    var id: UUID? = UUID()
    let productId: String
    let preview: String?
    let title: String?
    let size: String
    var quantity: Int
    let price: Double?
}
