//
// HH School
// Created by Shlyap1k.
//

import Foundation

@propertyWrapper
struct UserDefaultValue<T: Codable> {
    let key: String
    var userDefaults: UserDefaults = .standard

    var wrappedValue: T? {
        get {
            guard let modelData = userDefaults.data(forKey: key),
                  let model = try? JSONDecoder().decode(T.self, from: modelData)
            else {
                return userDefaults.value(forKey: key) as? T
            }
            return model
        }
        set {
            if let newValue {
                let encodedData = try? JSONEncoder().encode(newValue)
                userDefaults.set(encodedData == nil ? newValue : encodedData, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
