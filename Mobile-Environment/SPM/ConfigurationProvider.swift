//
//  ConfigurationProvider.swift
//  Mobile-Environment
//
//  Created by mac on 19/02/25.
//

import Foundation

public protocol ConfigurationProvider: AnyObject {
    /// The ConfigurationScheme for the active running build environment
    var buildScheme: ConfigurationScheme { get }
    var idMSID: NSNumber { get }
}
