// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - L10n

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum L10n {
    enum Auth {
        /// Войти
        static let action = L10n.tr("Localizable", "auth.action", fallback: "Войти")
        /// E-mail
        static let email = L10n.tr("Localizable", "auth.email", fallback: "E-mail")
        /// Пароль
        static let password = L10n.tr("Localizable", "auth.password", fallback: "Пароль")
        /// Еще нет аккаунта?
        static let register = L10n.tr("Localizable", "auth.register", fallback: "Еще нет аккаунта?")
        /// Localizable.strings
        ///   School-iOS
        ///
        ///   Created by Shlyap1k on 15.11.2023.
        static let title = L10n.tr("Localizable", "auth.title", fallback: "Авторизация")
    }

    enum Register {
        /// Зарегистрироваться
        static let action = L10n.tr("Localizable", "register.action", fallback: "Зарегистрироваться")
        /// E-mail
        static let email = L10n.tr("Localizable", "register.email", fallback: "E-mail")
        /// Фамилия
        static let lastName = L10n.tr("Localizable", "register.last_name", fallback: "Фамилия")
        /// Имя
        static let name = L10n.tr("Localizable", "register.name", fallback: "Имя")
        /// Род занятий
        static let occupation = L10n.tr("Localizable", "register.occupation", fallback: "Род занятий")
        /// Пароль
        static let password = L10n.tr("Localizable", "register.password", fallback: "Пароль")
        /// Регистрация
        static let title = L10n.tr("Localizable", "register.title", fallback: "Регистрация")
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// MARK: - BundleToken

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
