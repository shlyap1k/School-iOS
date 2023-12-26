//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct Product: Decodable, Encodable, Identifiable, Hashable {
    let id: String
    let title: String
    let department: String
    let price: Double
    let badge: [Badge]
    let preview: String
    let images: [String]
    let sizes: [Size]
    let description: String
    let details: [String]
}
