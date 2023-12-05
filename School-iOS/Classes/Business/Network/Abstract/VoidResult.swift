//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct VoidResult: Decodable {
    static let stub = VoidResult()

    var id: String? = UUID().uuidString
}
