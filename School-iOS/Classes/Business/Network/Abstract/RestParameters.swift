//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct RestParameters {
    // MARK: Lifecycle

    init(
        keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        wrapper: WrapperType?,
        errorWrapper: WrapperType?
    ) {
        self.keyDecoding = keyDecoding
        self.wrapper = wrapper
        self.errorWrapper = errorWrapper
    }

    // MARK: Internal

    typealias WrapperType = any AnyDecodableWrapper.Type

    var keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    let wrapper: WrapperType?
    let errorWrapper: WrapperType?
}
