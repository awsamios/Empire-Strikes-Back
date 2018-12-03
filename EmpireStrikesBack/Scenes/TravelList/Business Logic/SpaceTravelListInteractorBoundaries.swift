//
//  SpaceTravelListInteractorBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol SpaceTravelListDataStore {
  var trips: [Trip] { get }
}

protocol SpaceTravelListInteractorInput: class {
  /// Fetch all the space travels
  func fetchAvailableTrips()
}

protocol SpaceTravelListInteractorOutput: Loadable, ServiceFailureOutput {
  /// Present fetched Trips
  ///
  /// - parameter response: the trips data
  func presentTrips(response: TravelModels.List.Response)
}

