//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - PlaceholderViewModifier

struct PlaceholderViewModifier: ViewModifier {
    var model: PlaceholderModel?

    func body(content: Content) -> some View {
        content
            .overlay {
                if let model {
                    PlaceholderView(model: model)
                }
            }
    }
}

extension View {
    func placeholder(_ model: PlaceholderModel?) -> some View {
        modifier(PlaceholderViewModifier(model: model))
    }
}
