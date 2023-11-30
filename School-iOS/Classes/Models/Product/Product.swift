//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct Product: Decodable, Encodable, Identifiable {
    var id: String
    var title: String
    var department: String
    var price: Double
    var badge: [Badge]
    var preview: String
    var images: [String]
    var sizes: [Size]
    var description: String
    var details: [String]
}
