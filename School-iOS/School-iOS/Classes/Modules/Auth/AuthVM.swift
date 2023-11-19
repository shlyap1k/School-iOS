//
//  AuthVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import Foundation

class AuthVM: ObservableObject {
    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func auth() {
        isLoading = true
        print(emailModel.text)
        print(passwordModel.text)
    }

    func register() {
//        RegisterScreen(viewModel: RegisterVM())
    }
}
