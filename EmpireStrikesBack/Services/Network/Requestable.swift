//
//  Requestable.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//
import Foundation

protocol Requestable {
  var requestInput: RequestInput? { get }
  var dateFormatter: DateFormatter? { get set }
}

class GenericRemoteService: Requestable {
  
  var dateFormatter: DateFormatter?
  var requestInput: RequestInput?
  
  func execute<T: Codable>(
    _ responseType: T.Type,
    dispatcher: NetworkProvider, completion: ((ServiceResultObject<T, ServiceErrorType>) -> Void)?) {
    
    guard let request = self.requestInput else {
      completion?(ServiceResultObject.failure(ServiceErrorType.badInput))
      return
    }
    
    dispatcher.execute(request) { response in
      
      guard response.isSuccess, let value = response.value else {
        completion?(ServiceResultObject.failure(response.error))
        return
      }
      
      do {
        let jsonDecoder = JSONDecoder()
        if let dateFormatter = self.dateFormatter {
          jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        }
        
        let result = try jsonDecoder.decode(responseType, from: value)
        DispatchQueue.main.async {
          completion?(ServiceResultObject.success(result))
        }
      } catch {
        DispatchQueue.main.async {
          Logger.error(error.localizedDescription)
          completion?(ServiceResultObject.failure(ServiceErrorType.parsingError))
        }
      }
    }
  }
}
