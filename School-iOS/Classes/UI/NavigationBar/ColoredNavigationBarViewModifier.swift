//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

struct ColoredNavigationBar: ViewModifier {
    var background: Color
    var colorScheme: ColorScheme

    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(colorScheme, for: .navigationBar)
    }
}
