//
//  SpaceTravelListInteractorBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol SpaceTravelDetailsDataStore {
  /// the identifier of the trip
  var tripIdentifier: Int? { get set }
}

protocol SpaceTravelDetailsInteractorInput: class {
  /// Fetch trip details data
  func fetchTripDetails()
}

protocol SpaceTravelDetailsInteractorOutput: Loadable, ServiceFailureOutput {
  /// Present the fetched trip data
  ///
  /// - parameter response: the trip data
  func presentTripDetails(response: TravelModels.Details.Response)
}
