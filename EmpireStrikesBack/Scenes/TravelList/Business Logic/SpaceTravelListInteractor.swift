//
//  SpaceTravelListInteractor.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class SpaceTravelListInteractor: SpaceTravelListDataStore {
  var output: SpaceTravelListInteractorOutput?
  var spaceTravelWorker: SpaceTravelProvider
  
    var trips: [Trip] = []
  
  init(spaceTravelWorker: SpaceTravelProvider) {
    self.spaceTravelWorker = spaceTravelWorker
  }
}

extension SpaceTravelListInteractor: SpaceTravelListInteractorInput {
  
  func fetchAvailableTrips() {
    
    output?.showLoader()
    spaceTravelWorker.fetchSpaceTravelList { [weak self] result in
      
      guard let self = self else {
        return
      }
      
      self.output?.hideLoader()
      guard result.isSuccess, let trips = result.value else {
        self.output?.serviceFailure(error: result.error ?? .technical)
        return
      }
      
      self.trips = trips
      let response = TravelModels.List.Response(trips: trips)
      self.output?.presentTrips(response: response)
    }
  }
}
