// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Auth {
    /// Войти
    internal static let action = L10n.tr("Localizable", "auth.action", fallback: "Войти")
    /// E-mail
    internal static let email = L10n.tr("Localizable", "auth.email", fallback: "E-mail")
    /// Введите e-mail
    internal static let emailError = L10n.tr("Localizable", "auth.emailError", fallback: "Введите e-mail")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "auth.password", fallback: "Пароль")
    /// Пароль должен содержать как минимум 6 символов
    internal static let passwordError = L10n.tr("Localizable", "auth.passwordError", fallback: "Пароль должен содержать как минимум 6 символов")
    /// Еще нет аккаунта?
    internal static let register = L10n.tr("Localizable", "auth.register", fallback: "Еще нет аккаунта?")
    /// Localizable.strings
    ///   School-iOS
    /// 
    ///   Created by Shlyap1k on 15.11.2023.
    internal static let title = L10n.tr("Localizable", "auth.title", fallback: "Авторизация")
  }
  internal enum Placeholder {
    /// Корзина пуста
    internal static let emptyCart = L10n.tr("Localizable", "placeholder.emptyCart", fallback: "Корзина пуста")
    /// Пока здесь нет ни одного товара.
    internal static let emptyCatalog = L10n.tr("Localizable", "placeholder.emptyCatalog", fallback: "Пока здесь нет ни одного товара.")
    /// Нет соединения
    internal static let noConnection = L10n.tr("Localizable", "placeholder.noConnection", fallback: "Нет соединения")
    /// Обновить
    internal static let refresh = L10n.tr("Localizable", "placeholder.refresh", fallback: "Обновить")
    /// Что-то пошло не так
    internal static let unknown = L10n.tr("Localizable", "placeholder.unknown", fallback: "Что-то пошло не так")
  }
  internal enum ProductsList {
    /// Список товаров
    internal static let title = L10n.tr("Localizable", "productsList.title", fallback: "Список товаров")
  }
  internal enum Register {
    /// Зарегистрироваться
    internal static let action = L10n.tr("Localizable", "register.action", fallback: "Зарегистрироваться")
    /// E-mail
    internal static let email = L10n.tr("Localizable", "register.email", fallback: "E-mail")
    /// Введите e-mail
    internal static let emailError = L10n.tr("Localizable", "register.emailError", fallback: "Введите e-mail")
    /// Фамилия
    internal static let lastName = L10n.tr("Localizable", "register.last_name", fallback: "Фамилия")
    /// Имя
    internal static let name = L10n.tr("Localizable", "register.name", fallback: "Имя")
    /// Род занятий
    internal static let occupation = L10n.tr("Localizable", "register.occupation", fallback: "Род занятий")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "register.password", fallback: "Пароль")
    /// Пароль должен содержать как минимум 6 символов
    internal static let passwordError = L10n.tr("Localizable", "register.passwordError", fallback: "Пароль должен содержать как минимум 6 символов")
    /// Это поле должно быть заполнено
    internal static let requiredFieldError = L10n.tr("Localizable", "register.requiredFieldError", fallback: "Это поле должно быть заполнено")
    /// Регистрация
    internal static let title = L10n.tr("Localizable", "register.title", fallback: "Регистрация")
  }
  internal enum TabView {
    /// Корзина
    internal static let cartScreen = L10n.tr("Localizable", "tabView.cartScreen", fallback: "Корзина")
    /// Каталог
    internal static let productsScreen = L10n.tr("Localizable", "tabView.productsScreen", fallback: "Каталог")
    /// Профиль
    internal static let profileScreen = L10n.tr("Localizable", "tabView.profileScreen", fallback: "Профиль")
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
