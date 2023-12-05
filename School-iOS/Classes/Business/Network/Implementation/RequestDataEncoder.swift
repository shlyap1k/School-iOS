//
// HH School
// Created by Shlyap1k.
//

import Foundation

enum RequestDataEncoder {
    static func encode(
        _ data: some Encodable,
        encoderKeyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys,
        encoderDateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601
    ) -> Data? {
        if let json = data as? [String: Any] {
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        } else {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = encoderKeyEncodingStrategy
            encoder.dateEncodingStrategy = encoderDateEncodingStrategy
            return try? encoder.encode(data)
        }
    }

    static func multipartPayload(boundary: String, data: Data, mimeType: String, filename: String) -> Data {
        let payload = NSMutableData()
        let boundaryPrefix = Data("--\(boundary)\r\n".utf8)

        payload.append(boundaryPrefix)
        payload.append(Data("Content-Disposition: form-data; name=\"uploadedFile\"; filename=\"\(filename)\"\r\n".utf8))
        payload.append(Data("Content-Type: \(mimeType)\r\n\r\n".utf8))
        payload.append(data)
        payload.append(Data("\r\n".utf8))
        payload.append(Data("--".appending(boundary.appending("--")).utf8))

        return payload as Data
    }
}
