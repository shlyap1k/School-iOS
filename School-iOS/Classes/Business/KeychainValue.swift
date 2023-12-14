//
// HH School
// Created by Shlyap1k.
//

import Foundation
import KeychainAccess

// MARK: - KeychainValue

@propertyWrapper
struct KeychainValue<T: Codable> {
    let key: String
    var keychain = Keychain()
    var lock = NSLock()

    var wrappedValue: T? {
        get {
            guard let data = try? keychain.getData(key),
                  let model = try? JSONDecoder().decode(T.self, from: data)
            else {
                return T.self is String.Type ? keychain[string: key] as? T : nil
            }
            return model
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            if let model = newValue {
                if let modelData = try? JSONEncoder().encode(model) {
                    keychain[data: key] = modelData
                } else if let model = model as? String {
                    keychain[string: key] = model
                }
            } else {
                try? keychain.remove(key)
            }
        }
    }
}

// MARK: - NonOptionalKeychainValue

@propertyWrapper
struct NonOptionalKeychainValue<T: Codable> {
    let key: String
    let `default`: T
    var keychain = Keychain()
    var lock = NSLock()

    var wrappedValue: T {
        get {
            guard let data = try? keychain.getData(key),
                  let model = try? JSONDecoder().decode(T.self, from: data)
            else {
                return (T.self is String.Type ? keychain[string: key] as? T : nil) ?? `default`
            }
            return model
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            if let modelData = try? JSONEncoder().encode(newValue) {
                keychain[data: key] = modelData
            } else if let model = newValue as? String {
                keychain[string: key] = model
            }
        }
    }
}
