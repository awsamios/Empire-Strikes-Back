//
//  NetworkProvider.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit
import Alamofire

typealias NetworkCompletion = (NetworkServiceResult) -> Void

protocol NetworkProvider {
  init(environment: Environment)
  func execute(_ request: RequestInput, completion: NetworkCompletion?)
}

struct Environment {
  /// Name of the environment
  public var name: String
  
  /// Base URL of the environment
  public var host: String
  
  /// This is the list of common headers which will be part of each Request
  /// Some headers value maybe overwritten by Request's own headers
  public var headers: [String: Any] = [:]
  
  /// Cache policy
  public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
  
  init(_ host: String, name: String) {
    self.host = host
    self.name = name
  }
}

public protocol RequestInput {
  var path: String { get }
  var headers: [String: Any]? { get }
  var parameters: RequestParams? { get }
  var method: HTTPMethod { get }
  var encoding: ParameterEncoding { get }
}

public enum RequestParams {
  case body(_ : Encodable)
  case url(_ : [String: Any]?)
}

class ESBRequest: RequestInput {
  var path: String
  var headers: [String: Any]?
  var parameters: RequestParams?
  var method: HTTPMethod
  var encoding: ParameterEncoding
  
  init(
    path: String,
    method: HTTPMethod,
    encoding: ParameterEncoding = URLEncoding.default,
    parameters: RequestParams?,
    headers: [String: Any]? = nil) {
    
    self.path = path
    self.method = method
    self.parameters = parameters
    self.headers = headers
    self.encoding = encoding
  }
}
