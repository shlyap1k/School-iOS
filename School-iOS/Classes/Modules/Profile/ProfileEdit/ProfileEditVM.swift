//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation

class ProfileEditVM: ObservableObject {
    // MARK: Internal

    @Published var userImage: UserImageModel = .init()

    @Published var nameModel: InputFieldModel = .init(text: "")

    @Published var surnameModel: InputFieldModel = .init(text: "")

    @Published var occupationModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func validate() -> Bool {
        var isValid = true

        if !Validator.validate(.requiredField, value: nameModel.text) {
            isValid = false
            nameModel.error = L10n.Validation.requiredFieldError
        } else {
            nameModel.error = nil
        }

        if !Validator.validate(.requiredField, value: surnameModel.text) {
            isValid = false
            surnameModel.error = L10n.Validation.requiredFieldError
        } else {
            surnameModel.error = nil
        }

        if !Validator.validate(.requiredField, value: occupationModel.text) {
            isValid = false
            occupationModel.error = L10n.Validation.requiredFieldError
        } else {
            occupationModel.error = nil
        }

        return isValid
    }

    func loadProfile() {
        if let profile = appState.state.profile {
            nameModel.text = profile.name
            surnameModel.text = profile.surname
            occupationModel.text = profile.occupation
        }
    }

    func setImage(image: UserImageModel) {
        userImage = image
    }

    func saveProfileChanges() {
        guard validate() else {
            return
        }
        var changes: [UpdateUserPayload] = []
        if let profile = appState.state.profile {
            if profile.name != nameModel.text {
                print("update name")
                changes.append(
                    UpdateUserPayload(
                        operationType: 0,
                        path: "/name",
                        op: "replace",
                        from: profile.name,
                        value: nameModel.text
                    )
                )
            }
            if profile.surname != surnameModel.text {
                changes.append(
                    UpdateUserPayload(
                        operationType: 0,
                        path: "/surname",
                        op: "replace",
                        from: profile.surname,
                        value: surnameModel.text
                    )
                )
            }
            if profile.occupation != occupationModel.text {
                changes.append(
                    UpdateUserPayload(
                        operationType: 0,
                        path: "/occupation",
                        op: "replace",
                        from: profile.occupation,
                        value: occupationModel.text
                    )
                )
            }
        }
        if !changes.isEmpty {
            let request = UserRequest.updateUser(updateUserPayload: changes)
            isLoading = true
            Task {
                let result: RestResult<Profile> = await restProvider.make(request)
                switch result {
                case let .success(response):
                    appState.state.profile = response
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                case let .failure(reason):
                    occupationModel.error = reason.detail.message
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }
    }

    func saveImageChange() {
        Task {
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
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
