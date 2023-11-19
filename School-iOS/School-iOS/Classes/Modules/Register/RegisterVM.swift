//
//  RegisterVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import Factory
import Foundation

class RegisterVM: ObservableObject {
    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
    
    @Published var avatarUrlModel: InputFieldModel = .init(text: "")
    
    @Published var nameModel: InputFieldModel = .init(text: "")

    @Published var lastnameModel: InputFieldModel = .init(text: "")

    @Published var occupationModel: InputFieldModel = .init(text: "")

    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func register() {
        isLoading = true
        let request = RegisterRequest.register(avatarUrl: avatarUrlModel.text, name: nameModel.text, surname: lastnameModel.text, occupation: occupationModel.text, email: emailModel.text, password: passwordModel.text)
        Task {
            let result: RestResult<AuthResponse> = await restProvider.make(request)
            switch result {
            case let .success(response):
                appState.state.accessToken = response.accessToken
            case let .failure(reason):
                print(reason.detail.message)
                isLoading = false
            }
        }
    }
}
