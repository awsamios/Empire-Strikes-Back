//
//  SpaceTravelListRouterBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol SpaceTravelListDataPassing {
  var dataStore: SpaceTravelListDataStore? { get }
}

protocol SpaceTravelListRouterInput: class {
  /// Route to details view
  func routeToTripDetails(_ tripId: Int)
}
