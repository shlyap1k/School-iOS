//
//  AuthVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import Factory
import Foundation

class AuthVM: ObservableObject {
    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
    
    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func auth() {
        isLoading = true
        let request = AuthRequest.auth(email: emailModel.text, password: passwordModel.text)
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

    func register() {
//        RegisterScreen(viewModel: RegisterVM())
    }
}
