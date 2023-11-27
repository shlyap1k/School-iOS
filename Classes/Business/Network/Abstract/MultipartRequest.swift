//
// HH School
// Created by Shlyap1k.
//

import Foundation
import UIKit

// MARK: - MultipartRequest

protocol MultipartRequest: Request {
    var boundary: String { get }
    var filename: String { get }
    var mimeType: String { get }
    var data: Data? { get }
}

extension MultipartRequest {
    var contentType: String {
        "multipart/form-data; boundary=\(boundary)"
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
