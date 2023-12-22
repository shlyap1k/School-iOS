//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct OrderStatus: RawRepresentable, Codable, Equatable, Hashable {
    // MARK: Lifecycle

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // MARK: Public

    public static let inWork = OrderStatus(rawValue: "in_work")
    public static let cancelled = OrderStatus(rawValue: "cancelled")

    public var rawValue: String
}
