//
//  Date+Extensions.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

extension TimeZone {
  static var defaultTimezone: TimeZone {
    return TimeZone(abbreviation: "UTC")!
  }
}

// MARK: - Formatter

extension DateFormatter {
  /// The default date formatter.
  static var `default`: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.defaultTimezone
    formatter.locale = Locale(identifier: NSLocale.current.identifier)
    return formatter
  }
  
  /// A timezone date formatter (ISO format).
  static var ISOTimezoneDateFormatter: DateFormatter? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2017-12-09T14:12:51Z
    dateFormatter.timeZone = TimeZone.defaultTimezone
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter
  }
}


// MARK: - Date format

extension Date {
  /// Convert the current date to a readable string using the given format.
  ///
  /// - parameter format: The format of the output string.
  /// - returns: A readable string that represent the date.
  func toString(format: String) -> String {
    let formatter = DateFormatter.default
    formatter.dateFormat = format
    
    return formatter.string(from: self)
  }
  
  /// Get the time date as a readable string
  /// Output format: 7:35 PM
  var readableDateTime: String {
    return self.toString(format: "h:mm a")
  }
}


extension TimeInterval {
  var readbleDateTime: String? {
    // go from ms to s
    let seconds = self / 1000
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    return formatter.string(from: seconds)
  }
}
