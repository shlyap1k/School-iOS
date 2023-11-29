import SwiftUI

struct TypographyText: ViewModifier {
    init(typography: Typography) {
        self.typography = typography
    }

    func body(content: Content) -> some View {
        content
            .font(typography.font)
            .lineSpacing(typography.lineHeight - typography.fontLineHeight)
            .padding(.vertical, (typography.lineHeight - typography.fontLineHeight) / 2)
    }

    private let typography: Typography
}

extension View {
    func applyStyle(_ typography: Typography) -> some View {
        modifier(TypographyText(typography: typography))
    }
}
