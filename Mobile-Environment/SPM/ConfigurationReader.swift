//
//  ConfigurationReader.swift
//  Mobile-Environment
//
//  Created by mac on 19/02/25.
//


import Foundation

public class ConfigurationReader {
    /// `Any` value from your bundles Info.plist
    /// - Parameters:
    ///   - key: `ConfigurationKey`
    ///   - bundle: `Bundle`
    /// - Returns: Result for the returned value
    public static func plistObject(for key: ConfigurationKey, bundle: Bundle) -> Result<Any, ConfigurationError> {
        guard bundle.infoDictionary?.keys.contains(key.keyValue) == true else {
            return .failure(.invalidPlistKey)
        }

        guard let obj = bundle.object(forInfoDictionaryKey: key.keyValue) else {
            return .failure(.noPlistValueFound)
        }

        return .success(obj)
    }

    /// `String` value from your bundles Info.plist
    /// - Parameters:
    ///   - key: `ConfigurationKey`
    ///   - bundle: `Bundle`
    /// - Returns: Result for the returned value
    public static func plistString(for key: ConfigurationKey, bundle: Bundle) -> Result<String, ConfigurationError> {
        return plistValue(type: String.self, for: key, bundle: bundle)
    }

    /// `Bool` from your bundles Info.plist
    /// - Parameters:
    ///   - key: `ConfigurationKey`
    ///   - bundle: `Bundle`
    /// - Returns: Result for the returned value
    public static func plistBool(for key: ConfigurationKey, bundle: Bundle) -> Result<Bool, ConfigurationError> {
        return plistValue(type: Bool.self, for: key, bundle: bundle)
    }

    /// `Int` from your bundles Info.plist
    /// - Parameters:
    ///   - key: `ConfigurationKey`
    ///   - bundle: `Bundle`
    /// - Returns: Result for the returned value
    public static func plistInt(for key: ConfigurationKey, bundle: Bundle) -> Result<Int, ConfigurationError> {
        return plistValue(type: Int.self, for: key, bundle: bundle)
    }

    /// Generic `T` value from your bundles Info.plist
    /// - Parameters:
    ///   - key: `ConfigurationKey`
    ///   - bundle: `Bundle`
    /// - Returns: Result for the returned value
    public static func plistValue<T>(type: T.Type, for key: ConfigurationKey, bundle: Bundle) -> Result<T, ConfigurationError> {
        let result = plistObject(for: key, bundle: bundle)
        switch result {
        case .success(let value):
            if let typedValue = value as? T {
                return .success(typedValue)
            } else {
                return .failure(.invalidPlistValueType)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}


public enum ConfigurationError: Error {
    case invalidPlistKey
    case noPlistValueFound
    case invalidPlistValueType
    case unknownError(message: String)
}

public protocol ConfigurationKey {
    var keyValue: String { get }
}
