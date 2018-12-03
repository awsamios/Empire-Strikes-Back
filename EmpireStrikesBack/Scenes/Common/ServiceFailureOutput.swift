//
//  ServiceFailureOutput.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol ServiceFailureOutput: class {
  /// Manage service call failure
  ///
  /// - parameter error: error received from server when service call failed
  func serviceFailure(error: ServiceErrorType)
}
