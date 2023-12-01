//
// HH School
// Created by Shlyap1k.
//

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

        if !Validator.validate(.email, value: emailModel.text) {
            isValid = false
            emailModel.error = L10n.Register.emailError
        } else {
            emailModel.error = nil
        }

        if !Validator.validate(.password(minLength: 6), value: passwordModel.text) {
            isValid = false
            passwordModel.error = L10n.Register.passwordError
        } else {
            passwordModel.error = nil
        }

        if !Validator.validate(.requiredField, value: nameModel.text) {
            isValid = false
            nameModel.error = L10n.Register.requiredFieldError
        } else {
            nameModel.error = nil
        }

        if !Validator.validate(.requiredField, value: lastnameModel.text) {
            isValid = false
            lastnameModel.error = L10n.Register.requiredFieldError
        } else {
            lastnameModel.error = nil
        }

        if !Validator.validate(.requiredField, value: occupationModel.text) {
            isValid = false
            occupationModel.error = L10n.Register.requiredFieldError
        } else {
            occupationModel.error = nil
        }

        return isValid
    }

    func register() {
        guard validate() else {
            return
        }
        isLoading = true
        let request = AuthRequest.register(
            avatarUrl: nil,
            name: nameModel.text,
            surname: lastnameModel.text,
            occupation: occupationModel.text,
            email: emailModel.text,
            password: passwordModel.text
        )
        Task {
            let result: RestResult<RegisterResponse> = await restProvider.make(request)
            switch result {
            case let .success(response):
                appState.state.accessToken = response.accessToken
                appState.state.profile = response.profile
                
                switch userImage.imageState {
                case let .success(image):
                    guard let imageData = image.image.pngData() else {
                        return
                    }
                    let imageRequest = UserRequest.uploadPhoto(photo: imageData, uuid: UUID().uuidString)
                    let _: RestResult<VoidResult> = await restProvider.make(imageRequest)
                default:
                    return
                }
                
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
