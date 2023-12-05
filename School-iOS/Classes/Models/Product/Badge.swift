//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct Badge: Decodable, Encodable, Identifiable, Hashable {
    var id: UUID? = UUID()
    var value: String
    var color: String
}
