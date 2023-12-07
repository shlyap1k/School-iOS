//
//  SizeSelector.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import SwiftUI

struct SizeSelector: View {
//    @StateObject var viewModel: SizeSelectorModel
    let sizes: [Size]
    @State var selectedSize: Size? {
        willSet {
            print("aboba \(String(describing: newValue))")
        }
    }
    var body: some View {
        HStack {
            ForEach(sizes, id: \.self) { size in
                SizeItem(size: size, selectedSize: $selectedSize)
            }
        }
    }
}

#Preview {
    SizeSelector(sizes: [
            Size(value: "M", isAvailable: true),
            Size(value: "L", isAvailable: false),
            Size(value: "X", isAvailable: true)
        ]
    )
}
