//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

struct PlaceholderModel {
    static let emptyCatalog: PlaceholderModel = .init(
        image: Image(.ph),
        text: L10n.Placeholder.emptyCatalog
    )

    static let emptyCart: PlaceholderModel = .init(
        image: Image(.cartPh),
        text: L10n.Placeholder.emptyCart
    )

    let image: Image
    let text: String
    var isLoading: Binding<Bool> = .constant(false)
    var action: (() -> Void)?

    static func noConnection(isLoading: Binding<Bool> = .constant(false), action: (() -> Void)?) -> PlaceholderModel {
        PlaceholderModel(
            image: Image(.network),
            text: L10n.Placeholder.noConnection,
            isLoading: isLoading,
            action: action
        )
    }

    static func unknown(isLoading: Binding<Bool> = .constant(false), action: (() -> Void)?) -> PlaceholderModel {
        PlaceholderModel(
            image: Image(.rain),
            text: L10n.Placeholder.unknown,
            isLoading: isLoading,
            action: action
        )
    }
}
