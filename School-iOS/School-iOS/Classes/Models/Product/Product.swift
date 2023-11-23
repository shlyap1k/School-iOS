//
//  Product.swift
//  School-iOS
//
//  Created by Shlyap1k on 23.11.2023.
//

import Foundation

struct Product: Decodable, Encodable {
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
