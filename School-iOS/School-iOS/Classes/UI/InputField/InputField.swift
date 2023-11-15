//
//  InputField.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import SwiftUI

struct InputField: View {
    let title: String
    @Binding var model: InputFieldModel
    
    var body: some View {
        VStack {
            TextField(title, text: $model.text)
                .padding([.leading, .bottom], 16)
                .padding(.top, 18)
                .padding(.trailing, 52)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Assets.backgroundGray.swiftUIColor)
                        .frame(height: 56)
                }
        }
    }
}

#Preview {
    InputField(title: "Title", model: .constant(.init(
        text: "",
        error: "nil"
    )))
    .padding(16)
    .border(.red)
}
