//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct MenuItem: View {
    var title: String
    var action: (() -> Void) = {}

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .applyStyle(.regular16)
                    .foregroundStyle(.black)
                Spacer()
                Image(.arrowRight)
            }
            .frame(height: 56)
        }
    }
}

#Preview {
    MenuItem(title: "aboba", action: {})
}
