//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
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
    
    func createBody(boundary: String, data: Data, mimeType: String, filename: String) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = Data("--\(boundary)\r\n".utf8)
        
        body.append(boundaryPrefix)
        body.append(Data("Content-Disposition: form-data; name=\"uploadedFile\"; filename=\"\(filename)\"\r\n".utf8))
        body.append(Data("Content-Type: \(mimeType)\r\n\r\n".utf8))
        body.append(data)
        body.append(Data("\r\n".utf8))
        body.append(Data("--".appending(boundary.appending("--")).utf8))
        
        return body as Data
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
