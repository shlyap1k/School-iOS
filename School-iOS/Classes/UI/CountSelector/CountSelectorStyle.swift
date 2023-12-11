//
//  CountSelectorStyle.swift
//  School-iOS
//
//  Created by Shlyap1k on 10.12.2023.
//

import Foundation
import SwiftUI

struct CountSelectorStyle {
    // MARK: Lifecycle

    init(
        height: CGFloat,
        backgroundColor: Color
    ) {
        self.height = height
        self.backgroundColor = backgroundColor
    }

    // MARK: Internal
    var height: CGFloat
    var backgroundColor: Color
}
