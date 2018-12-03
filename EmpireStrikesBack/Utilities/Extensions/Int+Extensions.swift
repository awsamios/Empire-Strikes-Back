//
//  Int+Extensions.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

extension Formatter {
  static let withSeparator: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ","
    formatter.numberStyle = .decimal
    return formatter
  }()
}

extension Int {
  var formattedWithSeparator: String? {
    return Formatter.withSeparator.string(for: self)
  }
}
