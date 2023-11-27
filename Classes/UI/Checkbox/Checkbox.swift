//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct Checkbox: View {
    // MARK: Lifecycle

    init(
        style: CheckboxStyle,
        isOn: Binding<Bool> = .constant(true),
        label: String?
    ) {
        self.style = style
        self.label = label ?? ""
        _isOn = isOn
    }

    // MARK: Internal

    @Binding var isOn: Bool

    var body: some View {
        Button(action: {
            isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: isOn ? style.iconOn : style.iconOff)
                    .font(style.font)
                    .foregroundColor(style.textColor)
                Text(label)
                    .font(style.font)
                    .foregroundStyle(style.textColor)
            }
        })
    }

    // MARK: Private

    private var style: CheckboxStyle
    private var label: String
}

#Preview {
    Checkbox(style: .eyeCheckbox, isOn: .constant(true), label: "test")
}
