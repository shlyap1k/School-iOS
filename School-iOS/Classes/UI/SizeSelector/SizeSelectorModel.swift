//
//  SizeSelectorModel.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import Foundation
import SwiftUI

class SizeSelectorModel: ObservableObject {
    let sizes: [Size]
    @State var selected: Size?
    
    init(sizes: [Size], selected: Size? = nil) {
        self.sizes = sizes
        self.selected = selected
    }
}
