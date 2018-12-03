//
//  SpaceTravelDetailsInteractor.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class SpaceTravelDetailsInteractor: SpaceTravelDetailsDataStore {
  
  var tripIdentifier: Int?
  var output: SpaceTravelDetailsInteractorOutput?
  var travelWorker: SpaceTravelProvider
  
  init(travelWorker: SpaceTravelProvider) {
    self.travelWorker = travelWorker
  }
}

extension SpaceTravelDetailsInteractor: SpaceTravelDetailsInteractorInput {
  func fetchTripDetails() {
    guard let tripId = self.tripIdentifier else {
      output?.serviceFailure(error: .badInput)
      return
    }
    
    output?.showLoader()
    travelWorker.fetchTripDetails(tripId) { [weak self] result in
      guard let self = self else {
        return
      }
      
      self.output?.hideLoader()
      guard result.isSuccess, let trip = result.value else {
        self.output?.serviceFailure(error: result.error ?? .technical)
        return
      }
      
      let response = TravelModels.Details.Response(trip: trip)
      self.output?.presentTripDetails(response: response)
    }
  }
}
