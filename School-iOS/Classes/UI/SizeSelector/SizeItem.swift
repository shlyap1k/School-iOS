//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct SizeItem: View {
//    @ObservedObject var viewModel: SizeItemModel
    @Binding var selectedSize: Size?

    var size: Size

    var body: some View {
        Button(action: {
            selectedSize = size
        }) {
            ZStack {
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundStyle(
                        Assets.backgroundSizeItem.swiftUIColor
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
        selectedSize: .constant(nil), size: Size(value: "M", isAvailable: true)
    )
}
