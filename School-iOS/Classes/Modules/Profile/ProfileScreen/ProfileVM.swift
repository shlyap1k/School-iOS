//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation
import SwiftUI

// MARK: - ProfileVM

class ProfileVM: ObservableObject {
    // MARK: Internal

    @Published var profile: Profile = .init(name: "", surname: "", occupation: "", avatarId: "")

    @Published var userImage: UserImageModel = .init()

    @Published var isLoading: Bool = false

    func fetchProfile() {
        let request = UserRequest.fetchUser
        isLoading = true
        Task {
            let result: RestResult<ProfileResponse> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.profile = response.profile
                    self.fetchImage()
                }
            case .failure:
                return
            }
        }
    }

    func fetchImage() {
        guard profile.avatarId != "" else {
            return
        }

        let request = UserRequest.getPhoto(fileId: profile.avatarId)
        Task {
            let result: RestResult<Data> = await restProvider.make(
                request,
                parameters: RestParameters(
                    wrapper: nil,
                    errorWrapper: ErrorRestResponseWrapper<NetworkError>.self
                )
            )
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    if let uiImage = UIImage(data: response) {
                        self.userImage.imageState = .success(
                            .init(image: uiImage)
                        )
                    }
                    self.isLoading = false
                }
            case .failure:
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch self.userImage.imageState {
                    case .success:
                        return
                    default:
                        self.userImage.imageState = .empty
                    }
                }
            }
        }
    }

    func logout() {
        appState[\.accessToken] = nil
        appState[\.cart] = nil
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}
