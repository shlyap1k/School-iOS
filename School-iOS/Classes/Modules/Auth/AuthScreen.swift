//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - FocusedField

private enum FocusedField: Hashable {
    case email, password
}

// MARK: - AuthScreen

struct AuthScreen: View {
    // MARK: Internal

    @StateObject var viewModel: AuthVM = .init()

    var body: some View {
        VStack {
            ScrollView {
                InputField(title: L10n.Auth.email, capitalize: false, model: $viewModel.emailModel)
                    .padding(.top, 35)
                    .focused($isFocused, equals: .email)

                SecureInputField(title: L10n.Auth.password, model: $viewModel.passwordModel)
                    .padding(.top, 16)
                    .focused($isFocused, equals: .password)
            }
            .scrollIndicators(.hidden)

            Spacer()

            StyledButton(
                isLoading: $viewModel.isLoading,
                title: L10n.Auth.action,
                style: .blue
            ) {
                viewModel.auth()
            }

            NavigationLink(value: Routes.registration) {
                Text(L10n.Auth.register)
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
            }
            .padding([.top, .bottom], 16)
        }
        .onTapGesture {
            isFocused = nil
        }
        .padding(.horizontal, 16)
        .navigationTitle(L10n.Auth.title)
        .navigationDestination(for: Routes.self) { route in
            switch route {
            case .registration:
                RegisterScreen()
            }
        }
    }

    // MARK: Private

    @FocusState private var isFocused: FocusedField?
}

// MARK: - Routes

enum Routes {
    case registration
}

#Preview {
    NavigationStack {
        AuthScreen()
    }
}
