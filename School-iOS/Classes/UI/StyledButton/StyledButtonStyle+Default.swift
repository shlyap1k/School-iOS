//
// HH School
// Created by Shlyap1k.
//

import Foundation

extension StyledButtonStyle {
    static let blue = StyledButtonStyle(
        backgroundColor: Assets.blue.swiftUIColor,
        textColor: Assets.white.swiftUIColor,
        height: 56,
        cornerRadius: 8,
        fontWeight: .regular
    )

    static let plainText = StyledButtonStyle(
        backgroundColor: .clear,
        textColor: Assets.black.swiftUIColor,
        height: 22,
        cornerRadius: 8,
        fontWeight: .bold
    )
}
