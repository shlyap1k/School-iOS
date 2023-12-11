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
        cornerRadius: 8
    )
    
    static let blueSmall = StyledButtonStyle(
        backgroundColor: Assets.blue.swiftUIColor,
        textColor: Assets.white.swiftUIColor,
        height: 34,
        cornerRadius: 8
    )
    
    static let green = StyledButtonStyle(
        backgroundColor: Assets.green.swiftUIColor,
        textColor: Assets.white.swiftUIColor,
        height: 56,
        cornerRadius: 8
    )

    static let plainText = StyledButtonStyle(
        backgroundColor: .clear,
        textColor: Assets.black.swiftUIColor,
        height: 22,
        cornerRadius: 8
    )
}
