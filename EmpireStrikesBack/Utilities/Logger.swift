//
//  Logger.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

open class Logger {
  
  public enum LoggerMessageStatus: String {
    case info = "🔅 Info"
    case error = "❌ Error"
    case warning = "⚠️ Warning"
  }
  
  private static func log(
    _ message: String, status: LoggerMessageStatus, fileName: StaticString = #file,
    line: UInt = #line) {
    
    let file = String(describing: fileName).components(separatedBy: "/").last ?? String(describing: fileName)
    print("\(status.rawValue) - \(file)@\(line): \(message)")
  }
  
  public static func error(
    _ message: String, fileName: StaticString = #file, line: UInt = #line) {
    
    self.log(message, status: .error, fileName: fileName, line: line)
  }
  
  public static func warn(_ message: String, fileName: StaticString = #file, line: UInt = #line) {
    self.log(message, status: .warning, fileName: fileName, line: line)
  }
  
  public static func fatal(_ message: String, fileName: StaticString = #file, line: UInt = #line) {
    fatalError(message, file: fileName, line: line)
  }
  
  public static func info(_ message: String, fileName: StaticString = #file, line: UInt = #line) {
    self.log(message, status: .info, fileName: fileName, line: line)
  }
}
