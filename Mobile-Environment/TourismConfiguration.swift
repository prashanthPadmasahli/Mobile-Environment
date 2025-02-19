//
//  TourismConfiguration.swift
//  Mobile-Environment
//
//  Created by mac on 19/02/25.
//

import Foundation

final class TourismConfiguration: ConfigurationProvider {
    
    enum TourismConfigKey: String, ConfigurationKey {
        case appIdMSID
        case appVersion
        case appBuildNumber
        
        var keyValue: String {
            self.rawValue
        }
    }
    
    static var shared =  TourismConfiguration()
    
    lazy var buildScheme: ConfigurationScheme = {
        #if DEBUG
        return .debug
        #elseif UAT
        return .uat
        #else
        return .prod
        #endif
    }()
    
    var idMSID: NSNumber = {
        if case let .success(value) = ConfigurationReader.plistString(for: TourismConfigKey.appIdMSID, bundle: .main) {
            return NSNumber(pointer: value)
        } else {
            return -1
        }
    }()
    
    var appVersion: String = {
        if case let .success(value) = ConfigurationReader.plistString(for: TourismConfigKey.appVersion, bundle: .main) {
            return value
        }
        return ""
    }()
    
    var appBuildNumber: String = {
        if case let .success(value) = ConfigurationReader.plistString(for: TourismConfigKey.appBuildNumber, bundle: .main) {
            return value
        }
        return ""
    }()
    
}
