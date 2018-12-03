//
//  SpaceTravelListPresenterBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol SpaceTravelDetailsPresenterOutput: Loadable, ServiceFailureOutput {
  /// Display the details of the trip
  ///
  /// - parameter viewModel: the viewModel that contains the displayble data
  func displayTripDetails(viewModel: TravelModels.Details.ViewModel)
}
