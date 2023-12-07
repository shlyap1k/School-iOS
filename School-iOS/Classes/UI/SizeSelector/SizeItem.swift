//
//  SizeItem.swift
//  School-iOS
//
//  Created by Shlyap1k on 07.12.2023.
//

import SwiftUI

struct SizeItem: View {
//    @StateObject var viewModel: SizeItemModel
    
    let size: Size
    @Binding var selectedSize: Size?
    var body: some View {
        Button(action: {
            selectedSize = size
            print(selectedSize?.value ?? "string")
        }) {
            ZStack {
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundStyle(
                        .backgroundSizeItem
                            .opacity(size.isAvailable ? 1.0 : 0.5)
                    )
                    .cornerRadius(8)
                    .overlay {
                        if size.value == selectedSize?.value {
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 1)
                                .stroke(.blue, lineWidth: 2)
                        }
                    }
                Text(size.value)
                    .applyStyle(.bold14)
                    .foregroundStyle(.black)
            }
        }
        .disabled(!size.isAvailable)
    }
}

#Preview {
    SizeItem(
//        viewModel: SizeItemModel(
            size: Size(value: "M", isAvailable: true),
            selectedSize: .constant(nil)
//        )
    )
}
