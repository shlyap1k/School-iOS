//
//  AuthScreen.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import SwiftUI

struct AuthScreen: View {
    @StateObject var viewModel: AuthVM

    var body: some View {
        VStack {
            InputField(title: L10n.Auth.email, model: $viewModel.emailModel)
                .padding(.top, 35)

            InputField(title: L10n.Auth.password, model: $viewModel.passwordModel)
                .padding(.top, 16)

            Spacer()

            StyledButton(
                isLoading: $viewModel.isLoading,
                title: L10n.Auth.action,
                style: .blue
            ) {
                viewModel.auth()
            }

            StyledButton(
                title: L10n.Auth.register,
                style: .plainText
            ) {
                viewModel.register()
            }
            .padding([.top, .bottom], 16)
        }
        .padding(.horizontal, 16)
        .navigationTitle(L10n.Auth.title)
    }
}

#Preview {
    NavigationStack {
        AuthScreen(viewModel: AuthVM())
    }
}
