//
//  ServiceResultObject.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

public enum ServiceErrorType: String {
  case badInput
  case noData
  case invalidUrl
  case parsingError
  case technical
  case badRequest
  case serverError
  
  static func withError(_ error: Error) -> ServiceErrorType {
    let code = (error as NSError).code
    return ServiceErrorType(rawValue: "\(error._domain).\(code)") ?? .technical
  }
}

/// Default result from a network response for a service.
typealias NetworkServiceResult = ServiceResultObject<Data, ServiceErrorType>

public class ServiceResultObject<Value, Error> {
  var value: Value?
  var error: Error?
  
  /// Boolean value that determine whether the result is a success.
  var isSuccess: Bool {
    // success value can be nil without error.
    return self.error == nil
  }
  
  init(value: Value?, error: Error? = nil) {
    self.value = value
    self.error = error
  }
  
  /// Initialize an empty result object.
  convenience init() {
    self.init(value: nil)
  }
  
  static func success(_ value: Value? = nil) -> ServiceResultObject {
    let serviceResult = ServiceResultObject()
    serviceResult.value = value
    serviceResult.error = nil
    return serviceResult
  }
  
  static func failure(_ error: Error?) -> ServiceResultObject {
    let serviceResult = ServiceResultObject()
    serviceResult.error = error
    return serviceResult
  }
}
