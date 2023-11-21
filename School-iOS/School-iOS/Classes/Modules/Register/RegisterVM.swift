//
//  RegisterVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import _PhotosUI_SwiftUI
import CoreTransferable
import Factory
import Foundation
import PhotosUI

class RegisterVM: ObservableObject {
    // MARK: Internal

    @Published var userImage: UserImageModel = .init()

    @Published var nameModel: InputFieldModel = .init(text: "")

    @Published var lastnameModel: InputFieldModel = .init(text: "")

    @Published var occupationModel: InputFieldModel = .init(text: "")

    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false
    
    func validate() -> Bool {
        var isValid = true
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if !emailPred.evaluate(with: emailModel.text) {
            isValid = false
            emailModel.error = L10n.Register.emailError
        } else {
            emailModel.error = nil
        }
        
        if passwordModel.text.count < 6 {
            isValid = false
            passwordModel.error = L10n.Register.emailError
        } else {
            passwordModel.error = nil
        }
        
        if nameModel.text.isEmpty {
            isValid = false
            nameModel.error = L10n.Register.requiredFieldError
        } else {
            nameModel.error = nil
        }
        
        if lastnameModel.text.isEmpty {
            isValid = false
            lastnameModel.error = L10n.Register.requiredFieldError
        } else {
            lastnameModel.error = nil
        }
        
        if occupationModel.text.isEmpty {
            isValid = false
            occupationModel.error = L10n.Register.requiredFieldError
        } else {
            occupationModel.error = nil
        }
        
        return isValid
    }

    func register() {
        if validate() {
            isLoading = true
            let request = RegisterRequest.register(
                avatarUrl: "avatarUrlModel.text",
                name: nameModel.text,
                surname: lastnameModel.text,
                occupation: occupationModel.text,
                email: emailModel.text,
                password: passwordModel.text
            )
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

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
