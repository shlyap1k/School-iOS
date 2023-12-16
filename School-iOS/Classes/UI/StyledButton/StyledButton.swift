//
// HH School
// Created by Shlyap1k.
//

//
// Created by Heads and Handhs on 20.01.2023.
//
import SwiftUI

// MARK: - StyledButton

struct StyledButton: View {
    // MARK: Lifecycle

    init(
        isActive: Binding<Bool> = .constant(true),
        isLoading: Binding<Bool> = .constant(false),
        title: String,
        style: StyledButtonStyle,
        action: @escaping () -> Void
    ) {
        _isActive = isActive
        _isLoading = isLoading
        self.title = title
        self.style = style
        self.action = action
    }

    // MARK: Internal

    @Binding var isActive: Bool
    @Binding var isLoading: Bool

    var body: some View {
        GeometryReader { reader in
            Button(action: action) {
                if isLoading {
                    ZStack {
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .foregroundColor(style.backgroundColor)
                            .frame(width: reader.size.width, height: style.height)
                            .opacity(isActive ? 1 : 0.5)

                        LoaderView(color: style.textColor, lineWidth: 1.5, size: 18)
                    }
                } else {
                    Text(title)
//                        .applyStyle(style.typography)
                        .padding(.horizontal, 6)
                        .foregroundColor(style.textColor)
                        .frame(width: reader.size.width, height: style.height)
                        .background(style.backgroundColor)
                        .cornerRadius(style.cornerRadius)
                        .opacity(isActive ? 1 : 0.5)
                }
            }
            .disabled(!isActive || isLoading)
        }
        .frame(height: style.height)
    }

    // MARK: Private

    private var title: String
    private var style: StyledButtonStyle
    private var action: () -> Void
}

// MARK: - StyledButtonPreview_Previews

struct StyledButtonPreview_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StyledButton(title: "Text", style: .blue) {}
        }.padding(.horizontal, 16)
    }
}
