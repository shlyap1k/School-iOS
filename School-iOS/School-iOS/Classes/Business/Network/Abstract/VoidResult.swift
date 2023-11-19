//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

struct VoidResult: Decodable {
    static let stub = VoidResult()

    var id: String? = UUID().uuidString
}
