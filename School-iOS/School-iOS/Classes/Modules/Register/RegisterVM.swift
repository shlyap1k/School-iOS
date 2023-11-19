//
//  RegisterVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import Foundation

class RegisterVM: ObservableObject {
    @Published var nameModel: InputFieldModel = .init(text: "")

    @Published var lastnameModel: InputFieldModel = .init(text: "")

    @Published var occupationModel: InputFieldModel = .init(text: "")

    @Published var emailModel: InputFieldModel = .init(text: "")

    @Published var passwordModel: InputFieldModel = .init(text: "")

    @Published var isLoading: Bool = false

    func register() {
        isLoading = true
        print(nameModel.text)
        print(lastnameModel.text)
        print(occupationModel.text)
        print(emailModel.text)
        print(passwordModel.text)
    }
}
