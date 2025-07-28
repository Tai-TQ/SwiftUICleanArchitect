//
//  Storage.swift
//  FSStoreSwiftUI
//
//  Created by Truong Quoc Tai on 11/03/2024.
//

import Foundation

@propertyWrapper
public struct Storage<T: Codable> {
    public struct Wrapper<U>: Codable where U: Codable {
        let wrapped: U
    }

    private let key: String
    private let defaultValue: T

    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            do {
                let value = try JSONDecoder().decode(Wrapper<T>.self, from: data)
                return value.wrapped
            } catch {
                print("❌ [\(#fileID).\(#line)]: \(error.localizedDescription)")
                return defaultValue
            }
        }
        set {
            // Convert newValue to data
            do {
                let data = try JSONEncoder().encode(Wrapper(wrapped: newValue))

                // Set value to UserDefaults
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print("❌ [\(#fileID).\(#line)]: \(error.localizedDescription)")
            }
        }
    }
}
