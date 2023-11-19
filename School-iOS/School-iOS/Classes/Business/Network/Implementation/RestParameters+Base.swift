//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

extension RestParameters {
    // MARK: Public

    static func raw<Error: Decodable>(
        keyDecoding _: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        errorWrapper _: Error.Type? = nil
    ) -> RestParameters {
        RestParameters(
            wrapper: nil,
            errorWrapper: ErrorRestResponseWrapper<Error>.self
        )
    }

    static func base<T: Decodable>(
        keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        wrapped _: T.Type? = nil
    ) -> RestParameters {
        RestParameters(
            keyDecoding: keyDecoding,
            wrapper: BaseRestResponseWrapper<T>.self,
            errorWrapper: ErrorRestResponseWrapper<NetworkError>.self
        )
    }
}
