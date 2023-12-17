//
//  SizeItemModel.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import Foundation
import SwiftUI

class SizeItemModel: ObservableObject {
    let size: Size
    @Binding var selectedSize: Size?
    
    init(size: Size, selectedSize: Binding<Size?> = .constant(nil)) {
        self.size = size
        _selectedSize = selectedSize
    }
    
    var isSelected: Bool {
        guard let selectedSize = selectedSize else { return false }
        return size.value == selectedSize.value
    }
}
