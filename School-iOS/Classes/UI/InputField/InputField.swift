//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct InputField: View {
    let title: String
    var capitalize: Bool = true
    @Binding var model: InputFieldModel

    var body: some View {
        VStack {
            TextField(title, text: $model.text)
                .textInputAutocapitalization(capitalize ? .sentences : .never)
                .padding([.leading, .bottom, .top], 16)
                .padding(.trailing, 52)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Assets.backgroundGray.swiftUIColor)
                        .frame(height: 56)
                }

            if let error = model.error {
                Text(error)
                    .applyStyle(.regular12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Assets.red.swiftUIColor)
                    .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    InputField(title: "Title", model: .constant(.init(
        text: "", error: "abboba"
    )))
    .padding(16)
    .border(.red)
}
