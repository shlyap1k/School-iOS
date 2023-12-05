//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct Checkbox: View {
    // MARK: Lifecycle

    init(
        style: CheckboxStyle,
        isOn: Binding<Bool> = .constant(true)
    ) {
        self.style = style
        _isOn = isOn
    }

    // MARK: Internal

    @Binding var isOn: Bool

    var body: some View {
        Button(action: {
            isOn.toggle()
        }, label: {
            HStack {
                if isOn {
                    style.iconOn
                } else {
                    style.iconOff
                }
            }
        })
    }

    // MARK: Private

    private var style: CheckboxStyle
}

#Preview {
    Checkbox(style: .eyeCheckbox, isOn: .constant(true))
}
