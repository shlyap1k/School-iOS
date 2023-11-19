//
//  RegisterScreen.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import SwiftUI

struct RegisterScreen: View {
    @StateObject var viewModel: RegisterVM

    var body: some View {
        VStack {
            UserImageView(avatar: .constant(UserImageModel(image: Assets.image)))
                .padding(.top, 19)

            InputField(title: L10n.Register.name, model: $viewModel.nameModel)
                .padding(.top, 8)

            InputField(title: L10n.Register.lastName, model: $viewModel.lastnameModel)
                .padding(.top, 8)

            InputField(title: L10n.Register.occupation, model: $viewModel.occupationModel)
                .padding(.top, 8)

            InputField(title: L10n.Register.email, model: $viewModel.passwordModel)
                .padding(.top, 8)

            InputField(title: L10n.Register.password, model: $viewModel.emailModel)
                .padding(.top, 8)

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
        RegisterScreen(viewModel: RegisterVM())
    }
}
