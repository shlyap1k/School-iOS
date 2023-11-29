//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct NetworkError: Error, Decodable {
    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        cause = try container.decodeIfPresent(String.self, forKey: .message)
        kind = .regularNetworkError
    }

    init(kind: NetworkErrorKind) {
        message = nil
        cause = nil
        self.kind = kind
    }

    // MARK: Internal

    enum Detail {
        case unauthorized
        case noConnection
        case unknown
        case regular(message: String)

        // MARK: Internal

        var message: String {
            switch self {
            case .unauthorized:
                return "Попробуйте обновить данные"
            case .noConnection:
                return "Нет соединения"
            case .unknown:
                return "Что-то пошло не так"
            case let .regular(message):
                return message
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case message, cause, data
    }

    static let expiredCode: String = "EXPIRED"
    static let unauthorizedCode: String = "UNAUTHORIZED_REQUEST"

    let kind: NetworkErrorKind
    let message: String?
    let cause: String?

    var detail: Detail {
        switch kind {
        case .accessTokenLost, .unauthorized, .authExpired:
            return .unauthorized
        case .regularNetworkError:
            guard let message else {
                return .unknown
            }
            return .regular(message: message)
        case let .system(urlError):
            switch urlError {
            case URLError.notConnectedToInternet, URLError.networkConnectionLost:
                return .noConnection
            default:
                print("unknown")
                return .unknown
            }
        default:
            return .unknown
        }
    }
}
