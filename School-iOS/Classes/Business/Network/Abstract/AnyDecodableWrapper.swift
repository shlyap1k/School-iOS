//
// HH School
// Created by Shlyap1k.
//

import Foundation

protocol AnyDecodableWrapper: Decodable {
    associatedtype T: Decodable
    var wrapped: T { get }
}
