//
//  OrderProduct.swift
//  School-iOS
//
//  Created by Shlyap1k on 23.11.2023.
//

import Foundation

struct OrderProduct: Decodable, Encodable {
    var productId: String
    var size: String
    var quantity: Int
}
