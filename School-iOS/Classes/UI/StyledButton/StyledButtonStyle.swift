//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation
import SwiftUI

struct StyledButtonStyle {
    // MARK: Lifecycle

    init(
        backgroundColor: Color,
        textColor: Color,
        height: CGFloat,
        cornerRadius: CGFloat,
        fontWeight: Font.Weight
    ) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.height = height
        self.cornerRadius = cornerRadius
        self.fontWeight = fontWeight
    }

    // MARK: Internal

    var backgroundColor: Color
    var textColor: Color
    var height: CGFloat
    var cornerRadius: CGFloat
    var fontWeight: Font.Weight
}
