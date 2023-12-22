//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct Badge: Decodable, Encodable, Identifiable, Hashable {
    let id: UUID? = UUID()

    let value: String
    let color: String
}
