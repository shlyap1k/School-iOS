//
// HH School
// Created by Shlyap1k.
//

import Foundation

// MARK: - RestParameters

struct RestParameters {
    // MARK: Lifecycle

    init(
        keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecoding: JSONDecoder.DateDecodingStrategy = .customISO8601,
        wrapper: WrapperType?,
        errorWrapper: WrapperType?
    ) {
        self.keyDecoding = keyDecoding
        self.dateDecoding = dateDecoding
        self.wrapper = wrapper
        self.errorWrapper = errorWrapper
    }

    // MARK: Internal

    typealias WrapperType = any AnyDecodableWrapper.Type

    var keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    var dateDecoding: JSONDecoder.DateDecodingStrategy = .customISO8601
    let wrapper: WrapperType?
    let errorWrapper: WrapperType?
}

extension Formatter {
    static let iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()

    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}

extension JSONEncoder.DateEncodingStrategy {
    static let customISO8601 = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}
