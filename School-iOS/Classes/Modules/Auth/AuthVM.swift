//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation
import SwiftUI

class AuthVM: ObservableObject {
    // MARK: Internal

    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func validate() -> Bool {
        var isValid = true

        if !Validator.validate(.email, value: emailModel.text) {
            isValid = false
            emailModel.error = L10n.Validation.emailError
        } else {
            emailModel.error = nil
        }

        if !Validator.validate(.password(minLength: 6), value: passwordModel.text) {
            isValid = false
            passwordModel.error = L10n.Validation.passwordError
        } else {
            passwordModel.error = nil
        }

        return isValid
    }

    func auth() {
        guard validate() else {
            return
        }
        isLoading = true
        let request = AuthRequest.auth(email: emailModel.text, password: passwordModel.text)
        Task {
            let result: RestResult<AuthResponse> = await restProvider.make(request)
            switch result {
            case let .success(response):
                appState.state.accessToken = response.accessToken
                appState.state.profile = response.profile
            case let .failure(reason):
                emailModel.error = reason.detail.message
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
