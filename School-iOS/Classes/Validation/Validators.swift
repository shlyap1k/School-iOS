//
// HH School
// Created by Shlyap1k.
//

import Foundation

class Validator {
    // MARK: Internal

    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    static func validate(_ fieldType: FieldType, value: String) -> Bool {
        switch fieldType {
        case .requiredField:
            return !value.isEmpty
        case let .password(minLength):
            return validatePassword(value, minLength: minLength)
        case .email:
            return validateEmail(value)
        }
    }

    // MARK: Private

    private static func validatePassword(_ password: String, minLength: Int) -> Bool {
        password.count >= minLength
    }

    private static func validateEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
