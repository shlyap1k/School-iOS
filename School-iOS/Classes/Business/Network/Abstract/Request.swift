//
// HH School
// Created by Shlyap1k.
//

import Foundation
import UIKit

// MARK: - Request

protocol Request {
    var authRequired: Bool? { get } // nil if auth is optional
    var path: String { get }
    var urlParameters: [URLQueryItem]? { get }
    var contentType: String { get }
    var method: RestMethod { get }
    var body: Data? { get }
    var additionalHeaders: [String: String] { get }
}

extension Request {
    var authRequired: Bool? {
        true
    }

    var contentType: String {
        "application/json"
    }

    var urlParameters: [URLQueryItem]? {
        nil
    }

    var regularHeaders: [String: String] {
        [
            "Platform": "ios",
            "User-Agent": "iOS-App-\(Bundle.appVersion)",
            "Accept-Language": "ru-RU",
            "Date": DateFormatter.cached.string(from: Date.now),
            "X-App-Version": Bundle.appVersion,
            "X-App-Build-Number": Bundle.buildVersionNumber,
            "X-Request-Id": UUID().uuidString,
            "X-Device-Id": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "X-Platform": "ios",
        ]
    }

    var additionalHeaders: [String: String] {
        [:]
    }

    var body: Data? {
        nil
    }

    var mockData: Data? {
        nil
    }
}

private extension DateFormatter {
    static let cached = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        return df
    }()
}

private extension Bundle {
    static var appVersion: String {
        (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0.0"
    }

    static var buildVersionNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
}
