//
//  ColoredNavigationBarViewModifier.swift
//  School
//
//  Created by Shlyap1k on 22.12.2023.
//  Copyright © 2023 asigonin. All rights reserved.
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

