//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

struct CheckboxStyle {
    // MARK: Lifecycle

    init(
        textColor: Color,
        font: Font,
        iconOn: Image,
        iconOff: Image
    ) {
        self.textColor = textColor
        self.font = font
        self.iconOn = iconOn
        self.iconOff = iconOff
    }

    // MARK: Internal

    var textColor: Color
    var font: Font
    var iconOn: Image
    var iconOff: Image
}
