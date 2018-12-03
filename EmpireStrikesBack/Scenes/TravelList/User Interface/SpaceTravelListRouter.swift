//
//  SpaceTravelListRouter.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

class SpaceTravelListRouter: SpaceTravelListRouterInput, SpaceTravelListDataPassing {
  
  weak var view: UIViewController?
  var dataStore: SpaceTravelListDataStore?
  
  func routeToTripDetails(_ tripId: Int) {
    
    guard let source = view as? SpaceTravelListViewController,
      let destination = ModuleFactory.prepareTravelDetailsViewController() as? SpaceTravelDetailsViewController else {
        
        Logger.fatal("Source should be SpaceTravelListViewController and destination SpaceTravelDetailsViewController")
        return
    }
    
    var destinationDS = destination.router?.dataStore
    passDataToDetails(source: source.router?.dataStore, destination: &destinationDS, tripId: tripId)
    
    view?.navigationController?.pushViewController(destination, animated: true)
  }
}

// MARK: - Private methods

extension SpaceTravelListRouter {
  /// Construct and pass data to the details controller
  ///
  /// - parameter source: The source of data to pass
  /// - paramater destination: The destination into to pass data
  /// - paramater tripId: The identifier of the trip
  private func passDataToDetails(source: SpaceTravelListDataStore?, destination:
    inout SpaceTravelDetailsDataStore?, tripId: Int) {
    
    destination?.tripIdentifier = tripId
  }
}
