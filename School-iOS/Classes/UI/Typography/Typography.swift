import SwiftUI

// MARK: - Typography

struct Typography {
    // MARK: Lifecycle

    init(uiFont: UIFont, fontLineHeight: CGFloat? = nil, lineHeight: CGFloat) {
        self.uiFont = uiFont
        self.fontLineHeight = fontLineHeight ?? uiFont.lineHeight
        self.lineHeight = lineHeight
    }

    let uiFont: UIFont
    let fontLineHeight: CGFloat
    let lineHeight: CGFloat

    var font: SwiftUI.Font {
        Font(uiFont)
    }
}
