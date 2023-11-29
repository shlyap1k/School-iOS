//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct SecureInputField: View {
    let title: String
    @State private var isSecured: Bool = true
    @Binding var model: InputFieldModel

    var body: some View {
        VStack {
            Group {
                if isSecured {
                    SecureField(title, text: $model.text)
                } else {
                    TextField(title, text: $model.text)
                }
            }
            .padding([.leading, .bottom], 16)
            .padding(.top, 18)
            .padding(.trailing, 52)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Assets.backgroundGray.swiftUIColor)
                    .frame(height: 56)
            }
            .overlay {
                Checkbox(style: .eyeCheckbox, isOn: $isSecured, label: nil)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            if let error = model.error {
                Text(error)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.red)
                    .padding(.leading, 24)
            }
        }
    }
}

#Preview {
    SecureInputField(title: "Title", model: .constant(.init(
        text: "", error: "abboba"
    )))
    .padding(16)
    .border(.red)
}
