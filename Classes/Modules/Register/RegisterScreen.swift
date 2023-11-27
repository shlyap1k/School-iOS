//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct RegisterScreen: View {
    @StateObject var viewModel: RegisterVM = .init()

    var body: some View {
        VStack {
            EditableCircularUserImage(model: viewModel.userImage)
                .padding(.top, 19)

            InputField(title: L10n.Register.name, model: $viewModel.nameModel)
                .padding(.top, 16)

            InputField(title: L10n.Register.lastName, model: $viewModel.lastnameModel)
                .padding(.top, 16)

            InputField(title: L10n.Register.occupation, model: $viewModel.occupationModel)
                .padding(.top, 16)

            InputField(title: L10n.Register.email, model: $viewModel.emailModel)
                .padding(.top, 16)

            InputField(title: L10n.Register.password, model: $viewModel.passwordModel)
                .padding(.top, 16)

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
}

#Preview {
    NavigationStack {
        RegisterScreen()
    }
}
