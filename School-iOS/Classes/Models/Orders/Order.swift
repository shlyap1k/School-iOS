//
//  Order.swift
//  School-iOS
//
//  Created by Shlyap1k on 23.11.2023.
//

import Foundation

struct Order: Decodable, Encodable {
    var house: String
    var apartment: String
    var date: Date
    var products: [OrderProduct]
}
