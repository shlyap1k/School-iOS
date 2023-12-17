//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct CountSelector: View {
//    @ObservedObject var viewModel: CountSelectorModel

    @Binding var count: Int

    let style: CountSelectorStyle

    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(8)
                .backgroundStyle(style.backgroundColor)
                .frame(height: style.height)

            HStack(spacing: 0) {
                Button(action: { count -= 1 }) {
                    Text("-")
                        .applyStyle(.regular18)
                        .frame(width: 44, height: style.height)
                        .padding(.leading, 5)
                }.disabled(count == 1)

                Text("\(count)")
                    .applyStyle(.regular18)
                    .lineLimit(1)
                    .layoutPriority(100)
                    .frame(width: 52)

                Button(action: { count += 1 }) {
                    Text("+")
                        .applyStyle(.regular18)
                        .frame(width: 44, height: style.height)
                        .padding(.trailing, 5)
                }
            }
            .foregroundColor(.white)
        }
        .frame(width: 148)
    }
}

#Preview {
    HStack {
        CountSelector(count: .constant(1), style: .big)
        CountSelector(count: .constant(1), style: .small)
    }
}
