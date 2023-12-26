//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct SnackerView: View {
    @ObservedObject var model: SnackerModel

    var body: some View {
        ZStack(alignment: .center) {
            model.background
                .overlay(alignment: .center) {
                    Text(model.text)
                        .applyStyle(.regular18)
                        .foregroundStyle(model.fontColor)
                        .padding(.top, 42)
                }
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .ignoresSafeArea()
        }
        .onTapGesture {
            model.isPresented.toggle()
        }
    }
}

#Preview {
    SnackerView(model: .init())
}
