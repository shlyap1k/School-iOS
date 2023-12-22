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

    @Published var imageError: String?

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

    func getChanges() -> [UpdateUserPayload] {
        var changes: [UpdateUserPayload] = []
        if let profile = appState.state.profile {
            if profile.name != nameModel.text {
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
        return changes
    }

    func saveProfileChanges() {
        guard validate() else {
            return
        }
        let changes: [UpdateUserPayload] = getChanges()

        if !changes.isEmpty {
            let request = UserRequest.updateUser(updateUserPayload: changes)
            isLoading = true
            Task {
                let result: RestResult<Profile> = await restProvider.make(request)
                switch result {
                case let .success(response):
                    appState.state.profile = response
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading = false
                        self?.saveImageChange()
                    }
                case let .failure(reason):
                    occupationModel.error = reason.detail.message
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading = false
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
            case .failure:
                DispatchQueue.main.async { [weak self] in
                    self?.imageError = L10n.Profile.Edit.imageError
                }
            case .empty:
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                }
            case .loading:
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = true
                }
            }
        }
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
