//
//  AuthVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import Factory
import Foundation

class AuthVM: ObservableObject {
    // MARK: Internal

    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func validate() -> Bool {
        var isValid = true

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        if !emailPred.evaluate(with: emailModel.text) {
            isValid = false
            emailModel.error = L10n.Auth.emailError
        } else {
            emailModel.error = nil
        }

        if passwordModel.text.count < 6 {
            isValid = false
            passwordModel.error = L10n.Auth.passwordError
        } else {
            passwordModel.error = nil
        }

        return isValid
    }

    func auth() {
        if validate() {
            isLoading = true
            let request = AuthRequest.auth(email: emailModel.text, password: passwordModel.text)
            Task {
                let result: RestResult<AuthResponse> = await restProvider.make(request)
                switch result {
                case let .success(response):
                    appState.state.accessToken = response.accessToken
                case let .failure(reason):
                    emailModel.error = reason.detail.message
                    isLoading = false
                }
            }
        }
    }

    func register() {
//        RegisterScreen(viewModel: RegisterVM())
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
