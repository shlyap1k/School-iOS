//
//  SizeSelectorModel.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import Foundation
import SwiftUI

class SizeSelectorModel: ObservableObject {
    var sizes: [Size] = []
    @Published var selectedSize: Size?
    
    init(sizes: [Size]) {
        self.sizes = sizes
    }
}
