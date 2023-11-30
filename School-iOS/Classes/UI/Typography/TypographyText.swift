//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - TypographyText

struct TypographyText: ViewModifier {
    // MARK: Lifecycle

    init(typography: Typography) {
        self.typography = typography
    }

    // MARK: Internal

    func body(content: Content) -> some View {
        content
            .font(typography.font)
            .lineSpacing(typography.lineHeight - typography.fontLineHeight)
            .padding(.vertical, (typography.lineHeight - typography.fontLineHeight) / 2)
    }

    // MARK: Private

    private let typography: Typography
}

extension View {
    func applyStyle(_ typography: Typography) -> some View {
        modifier(TypographyText(typography: typography))
    }
}
