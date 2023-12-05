
import Foundation
import SwiftUI

struct PlaceholderModel {
    let image: Image
    let text: String
    var isLoading: Binding<Bool> = .constant(false)
    var action: (() -> Void)?
    
    static let emptyCatalog: PlaceholderModel = PlaceholderModel(
        image: Image(.ph),
        text: L10n.Placeholder.emptyCatalog
    )
    
    static let emptyCart: PlaceholderModel = PlaceholderModel(
        image: Image(.cartPh),
        text: L10n.Placeholder.emptyCart
    )
    
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
