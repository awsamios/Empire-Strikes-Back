//
//  SpaceTravelWorker.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class SpaceTravelWorker: GenericRemoteService, SpaceTravelProvider {
  
  private var environment: Environment!
  var networkService: NetworkProvider!
  
  override init() {
    super.init()
    
    environment = Environment(VendorKeyProvider.hostServiceAPI, name: VendorKeyProvider.envConfiguration.rawValue)
    networkService = Network(environment: self.environment)
    dateFormatter = DateFormatter.ISOTimezoneDateFormatter
  }
  
  func fetchSpaceTravelList(completion: SpaceTravelResultCompletion?) {
    
    let requestParams = RequestParams.url([:])
    requestInput = ESBRequest(path: "trips", method: .get, parameters: requestParams)
    
    execute([Trip].self, dispatcher: networkService, completion: completion)
  }
  
  func fetchTripDetails(_ identifier: Int, completion: SpaceTravelDetailsResultCompletion?) {
    
    let path = "trips/\(identifier)"
    let requestParams = RequestParams.url([:])
    requestInput = ESBRequest(path: path, method: .get, parameters: requestParams)
    
    execute(Trip.self, dispatcher: networkService, completion: completion)
  }
}
