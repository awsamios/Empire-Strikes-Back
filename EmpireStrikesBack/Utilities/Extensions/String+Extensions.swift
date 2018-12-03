//
//  String+Extensions.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

extension String {
  /// Get the localized string
  public var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
  
  mutating func removeFirstChar(_ char: String) {
    if self.starts(with: char) {
      self.removeFirst(1)
    }
  }
}

extension String {
  /// Get the ISO date from the current string.
  var isoDate: Date? {
    let formatter = DateFormatter.ISOTimezoneDateFormatter
    let date = formatter?.date(from: self)
    return date
  }
}
