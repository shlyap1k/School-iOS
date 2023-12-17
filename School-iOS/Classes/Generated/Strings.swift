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
    /// Пароль
    internal static let password = L10n.tr("Localizable", "auth.password", fallback: "Пароль")
    /// Еще нет аккаунта?
    internal static let register = L10n.tr("Localizable", "auth.register", fallback: "Еще нет аккаунта?")
    /// Localizable.strings
    ///   School-iOS
    /// 
    ///   Created by Shlyap1k on 15.11.2023.
    internal static let title = L10n.tr("Localizable", "auth.title", fallback: "Авторизация")
  }
  internal enum Cart {
    /// Оформить
    internal static let checkout = L10n.tr("Localizable", "cart.checkout", fallback: "Оформить")
    /// Заказ успешно оформлен!
    internal static let success = L10n.tr("Localizable", "cart.success", fallback: "Заказ успешно оформлен!")
    /// Корзина
    internal static let title = L10n.tr("Localizable", "cart.title", fallback: "Корзина")
  }
  internal enum CartCheckout {
    /// Улица, дом
    internal static let address = L10n.tr("Localizable", "cartCheckout.address", fallback: "Улица, дом")
    /// Квартира
    internal static let apartment = L10n.tr("Localizable", "cartCheckout.apartment", fallback: "Квартира")
    /// Оформить
    internal static let checkout = L10n.tr("Localizable", "cartCheckout.checkout", fallback: "Оформить")
    /// шт.
    internal static let count = L10n.tr("Localizable", "cartCheckout.count", fallback: "шт.")
    /// Дата доставки
    internal static let deliveryDate = L10n.tr("Localizable", "cartCheckout.deliveryDate", fallback: "Дата доставки")
    /// Данные для доставки
    internal static let deliveryDetails = L10n.tr("Localizable", "cartCheckout.deliveryDetails", fallback: "Данные для доставки")
    /// Товары в заказе
    internal static let products = L10n.tr("Localizable", "cartCheckout.products", fallback: "Товары в заказе")
    /// Размер
    internal static let size = L10n.tr("Localizable", "cartCheckout.size", fallback: "Размер")
    /// Оформление заказа
    internal static let title = L10n.tr("Localizable", "cartCheckout.title", fallback: "Оформление заказа")
  }
  internal enum OrdersList {
    /// Вы действительно желаете отменить заказ
    internal static let cancelConfirm = L10n.tr("Localizable", "ordersList.cancelConfirm", fallback: "Вы действительно желаете отменить заказ")
    /// Отмена
    internal static let cancelDelivery = L10n.tr("Localizable", "ordersList.cancelDelivery", fallback: "Отмена")
    /// Заказ отменён
    internal static let cancelled = L10n.tr("Localizable", "ordersList.cancelled", fallback: "Заказ отменён")
    /// Оставить заказ
    internal static let cancelNo = L10n.tr("Localizable", "ordersList.cancelNo", fallback: "Оставить заказ")
    /// Да, отменить заказ
    internal static let cancelYes = L10n.tr("Localizable", "ordersList.cancelYes", fallback: "Да, отменить заказ")
    /// Доставим
    internal static let delivery = L10n.tr("Localizable", "ordersList.delivery", fallback: "Доставим")
    /// Заказ
    internal static let order = L10n.tr("Localizable", "ordersList.order", fallback: "Заказ")
    /// Мои заказы
    internal static let title = L10n.tr("Localizable", "ordersList.title", fallback: "Мои заказы")
  }
  internal enum Placeholder {
    /// Корзина пуста
    internal static let emptyCart = L10n.tr("Localizable", "placeholder.emptyCart", fallback: "Корзина пуста")
    /// Пока здесь нет ни одного товара.
    internal static let emptyCatalog = L10n.tr("Localizable", "placeholder.emptyCatalog", fallback: "Пока здесь нет ни одного товара.")
    /// Пока здесь нет ни одного заказа
    internal static let emptyOrders = L10n.tr("Localizable", "placeholder.emptyOrders", fallback: "Пока здесь нет ни одного заказа")
    /// Нет соединения
    internal static let noConnection = L10n.tr("Localizable", "placeholder.noConnection", fallback: "Нет соединения")
    /// Обновить
    internal static let refresh = L10n.tr("Localizable", "placeholder.refresh", fallback: "Обновить")
    /// Что-то пошло не так
    internal static let unknown = L10n.tr("Localizable", "placeholder.unknown", fallback: "Что-то пошло не так")
  }
  internal enum ProductDetails {
    /// Купить
    internal static let buy = L10n.tr("Localizable", "productDetails.buy", fallback: "Купить")
    /// В корзину
    internal static let cart = L10n.tr("Localizable", "productDetails.cart", fallback: "В корзину")
    /// Размер
    internal static let size = L10n.tr("Localizable", "productDetails.size", fallback: "Размер")
    /// Характеристики
    internal static let specs = L10n.tr("Localizable", "productDetails.specs", fallback: "Характеристики")
  }
  internal enum ProductsList {
    /// Список товаров
    internal static let title = L10n.tr("Localizable", "productsList.title", fallback: "Список товаров")
  }
  internal enum Profile {
    internal enum Logout {
      /// Выйти
      internal static let action = L10n.tr("Localizable", "profile.Logout.action", fallback: "Выйти")
      /// Отмена
      internal static let cancel = L10n.tr("Localizable", "profile.Logout.cancel", fallback: "Отмена")
      /// Выйти из профиля?
      internal static let title = L10n.tr("Localizable", "profile.Logout.title", fallback: "Выйти из профиля?")
    }
    internal enum Menu {
      /// Выйти
      internal static let logout = L10n.tr("Localizable", "profile.Menu.logout", fallback: "Выйти")
      /// Мои заказы
      internal static let ordersList = L10n.tr("Localizable", "profile.Menu.ordersList", fallback: "Мои заказы")
    }
    internal enum Edit {
      /// Сохранить
      internal static let action = L10n.tr("Localizable", "profile.edit.action", fallback: "Сохранить")
      /// Не удалось загрузить картинку
      internal static let imageError = L10n.tr("Localizable", "profile.edit.imageError", fallback: "Не удалось загрузить картинку")
      /// Имя
      internal static let name = L10n.tr("Localizable", "profile.edit.name", fallback: "Имя")
      /// Род занятий
      internal static let occupation = L10n.tr("Localizable", "profile.edit.occupation", fallback: "Род занятий")
      /// Фамилия
      internal static let surname = L10n.tr("Localizable", "profile.edit.surname", fallback: "Фамилия")
      /// Редактирование профиля
      internal static let title = L10n.tr("Localizable", "profile.edit.title", fallback: "Редактирование профиля")
    }
  }
  internal enum Register {
    /// Зарегистрироваться
    internal static let action = L10n.tr("Localizable", "register.action", fallback: "Зарегистрироваться")
    /// E-mail
    internal static let email = L10n.tr("Localizable", "register.email", fallback: "E-mail")
    /// Фамилия
    internal static let lastName = L10n.tr("Localizable", "register.last_name", fallback: "Фамилия")
    /// Имя
    internal static let name = L10n.tr("Localizable", "register.name", fallback: "Имя")
    /// Род занятий
    internal static let occupation = L10n.tr("Localizable", "register.occupation", fallback: "Род занятий")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "register.password", fallback: "Пароль")
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
  internal enum Validation {
    /// Введите e-mail
    internal static let emailError = L10n.tr("Localizable", "validation.emailError", fallback: "Введите e-mail")
    /// Пароль должен содержать как минимум 6 символов
    internal static let passwordError = L10n.tr("Localizable", "validation.passwordError", fallback: "Пароль должен содержать как минимум 6 символов")
    /// Это поле должно быть заполнено
    internal static let requiredFieldError = L10n.tr("Localizable", "validation.requiredFieldError", fallback: "Это поле должно быть заполнено")
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
