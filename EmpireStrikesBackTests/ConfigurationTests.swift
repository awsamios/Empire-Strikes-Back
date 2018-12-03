//
//  ConfigurationTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 02/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation
import XCTest
@testable import EmpireStrikesBack

class ConfigurationTests: XCTestCase {
  
  func testConfig() {
    XCTAssertEqual(VendorKeyProvider.envConfiguration, .development)
  }
}
