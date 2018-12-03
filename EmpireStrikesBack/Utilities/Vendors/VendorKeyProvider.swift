//
//  VendorKeyProvider.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation
/// Read a value from the bundle options for a given key.
///
/// - parameter key: The option's key.
/// - returns: The value or `nil`.
private func bundleOption(_ key: String) -> Any? {
  return Bundle.main.object(forInfoDictionaryKey: key)
}

/// Read a string from the bundle options for a given key.
///
/// - parameter key: The option's key.
/// - returns: The value or `nil`.
private func stringBundleOption(_ key: String) -> String? {
  return bundleOption(key) as? String
}

// All Configuration
enum EnvConfiguration: String {
  case development
  case production
}


/// Static class that provide an access to the shared vendor's private keys.
class VendorKeyProvider {
  
  /// The current envConfiguration, default value is `production`
  static let envConfiguration: EnvConfiguration = {
    let env = stringBundleOption("CURRENT_ENV_CONFIGURATION") ?? ""
    return EnvConfiguration(rawValue: env) ?? EnvConfiguration.production
  }()
  
  
  /// current Api Host.
  ///
  /// - returns: the api host string according to the current envConfiguration
  static let hostServiceAPI: String = {
    switch envConfiguration {
    case .development:
      return "https://starwars.chauffeur-prive.com" // Use dev endpoint here
      
    case .production:
      return "https://starwars.chauffeur-prive.com"
    }
  }()
}
