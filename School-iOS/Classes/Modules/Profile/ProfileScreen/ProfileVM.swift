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
//
//    @Published var image: UIImage? = .init(data: Data())

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
            case let .failure(reason):
                print(reason.detail.message)
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
                    wrapper: nil, // Data.self,
                    errorWrapper: ErrorRestResponseWrapper<NetworkError>.self
                )
            )
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.userImage.imageState = .success(
                        .init(
                            image: UIImage(data: response)!
                        )
                    )
                    self.isLoading = false
                }
            case let .failure(reason):
                print(reason.detail.message)
            }
        }
    }

    func logout() {
        appState[\.accessToken] = nil
    }

    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}

// MARK: - Data + AnyDecodableWrapper

extension Data: AnyDecodableWrapper {
    var wrapped: Data {
        self
    }

    typealias T = Data
}
