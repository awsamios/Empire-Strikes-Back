//
//  Network.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation
import Alamofire

class Network: NetworkProvider {
  private static let serviceTimeout: TimeInterval = 10
  
  private static let alamofireManager: SessionManager = {
    return Alamofire.SessionManager(timeout: Network.serviceTimeout)
  }()
  
  private var environment: Environment
  
  required public init(environment: Environment) {
    self.environment = environment
  }
  
  /// Executes a given request and return result or error in the completion
  ///
  /// - parameter request: the request to execute
  /// - paramerter completion to execute in case of success or error
  func execute(_ inputRequest: RequestInput, completion: NetworkCompletion?) {
    guard let urlRequest = self.prepareRequest(inputRequest), let url = urlRequest.url else {
      completion?(NetworkServiceResult.failure(ServiceErrorType.badInput))
      return
    }
    
    switch inputRequest.parameters {
    case .url(let params)?:
      self.execute(
        url: url,
        method: inputRequest.method,
        encoding: inputRequest.encoding,
        parameters: params,
        completion: completion)
      
    case .body?:
      self.execute(request: urlRequest, completion: completion)
      
    default:
      break
    }
  }
  
  func execute(request: URLRequest, completion: NetworkCompletion? ) {
    
    Logger.info(request.url?.absoluteString ?? "")
    Alamofire.request(request)
      .validate()
      .responseData { response in
        self.handleResponse(response, completion: completion)
    }
  }
  
  /// Executes a given url and return result or error in the completion
  ///
  /// - parameter url: the url to execute
  /// - paramerter completion to execute in case of success or error
  func execute(url: URL,
               method: HTTPMethod,
               encoding: ParameterEncoding,
               parameters: [String: Any]?,
               completion: NetworkCompletion?) {
    
    Logger.info(url.absoluteString)
    
    if let paramsString = parameters?.description {
      Logger.info(paramsString)
    }
    
    Network.alamofireManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil)
      .validate()
      .responseData { response in
        
        self.handleResponse(response, completion: completion)
    }
  }
  
  private func handleResponse(_ response: DataResponse<Data>, completion: NetworkCompletion?) {
    
    switch response.result {
    case .success(let data):
      completion?(NetworkServiceResult.success(data))
      
    case .failure(let error):
      if let response = response.response, response.statusCode == 400 {
        completion?(NetworkServiceResult.failure(ServiceErrorType.badRequest))
      }
      else {
        
        let url = response.request?.url?.absoluteString
        Logger.error("Service Technical Fail\nURL: '\(url ?? "No URL")'")
        
        let serviceError = ServiceErrorType.withError(error)
        completion?(NetworkServiceResult.failure(serviceError))
      }
    }
  }
}

extension Network {
  /// Prepares the request with given input data
  ///
  /// - parameter requestInput: the input data of the request to execute
  /// - returns: a complete url request
  private func prepareRequest(_ requestInput: RequestInput) -> URLRequest? {
    let fullUrl = "\(self.environment.host)/\(requestInput.path)"
    
    guard let url = URL(string: fullUrl) else {
      return nil
    }
    
    var urlRequest = URLRequest(url: url)
    
    // setup http method
    urlRequest.httpMethod = requestInput.method.rawValue
    
    // Add headers from environment and request
    environment.headers.forEach { urlRequest.addValue($0.value as? String ?? "", forHTTPHeaderField: $0.key) }
    
    requestInput.headers?.forEach { urlRequest.addValue($0.value as? String ?? "", forHTTPHeaderField: $0.key )}
    
    switch requestInput.parameters {
    case .body(let params)?:
      
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
      
      if let jsonData = params.toJSONData() {
        urlRequest.httpBody = jsonData
      }
      
    default:
      break
    }
    
    return urlRequest
  }
}

extension Alamofire.SessionManager {
  /// Initialize a request manager with a given timeout value.
  ///
  /// - parameter timeout: The manager timeout value (in seconds).
  convenience init(timeout: TimeInterval, cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) {
    
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = cachePolicy
    configuration.timeoutIntervalForRequest = timeout
    configuration.timeoutIntervalForResource = timeout
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    self.init(
      configuration: configuration)
  }
}

extension Encodable {
  func toJSONData() -> Data? {
    return try? JSONEncoder().encode(self)
  }
}
