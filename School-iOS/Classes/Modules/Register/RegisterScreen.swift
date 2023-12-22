//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - FocusedField

private enum FocusedField: Hashable {
    case name, lastname, occupation, email, password
}

// MARK: - RegisterScreen

struct RegisterScreen: View {
    // MARK: Internal

    @StateObject var viewModel: RegisterVM = .init()

    var body: some View {
        VStack {
            ScrollView {
                EditableCircularUserImage(model: viewModel.userImage)
                    .padding(.bottom, 19)
                VStack(spacing: 16) {
                    InputField(title: L10n.Register.name, model: $viewModel.nameModel)
                        .focused($isFocused, equals: .name)

                    InputField(title: L10n.Register.lastName, model: $viewModel.lastnameModel)
                        .focused($isFocused, equals: .lastname)

                    InputField(title: L10n.Register.occupation, model: $viewModel.occupationModel)
                        .focused($isFocused, equals: .occupation)

                    InputField(title: L10n.Register.email, capitalize: false, model: $viewModel.emailModel)
                        .focused($isFocused, equals: .email)

                    SecureInputField(title: L10n.Register.password, model: $viewModel.passwordModel)
                        .focused($isFocused, equals: .password)
                }
            }
            .scrollIndicators(.hidden)
            .onTapGesture {
                isFocused = nil
            }

            Spacer()

            StyledButton(
                isLoading: $viewModel.isLoading,
                title: L10n.Register.action,
                style: .blue
            ) {
                viewModel.register()
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .navigationTitle(L10n.Register.title)
    }

    // MARK: Private

    @FocusState private var isFocused: FocusedField?
}

#Preview {
    NavigationStack {
        RegisterScreen()
    }
}
