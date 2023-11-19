//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

protocol AnyDecodableWrapper: Decodable {
    associatedtype T: Decodable
    var wrapped: T { get }
}
