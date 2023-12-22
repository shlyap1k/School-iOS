//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

extension View {
    func navigationBarBackground(
        background: Color = .orange,
        fontColor: ColorScheme = .light
    ) -> some View {
        modifier(
            ColoredNavigationBar(
                background: background,
                colorScheme: fontColor
            )
        )
    }
}
