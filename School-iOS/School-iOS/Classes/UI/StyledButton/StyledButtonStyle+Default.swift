//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

extension StyledButtonStyle {
    static let blue = StyledButtonStyle(
        backgroundColor: Assets.blue.swiftUIColor,
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
