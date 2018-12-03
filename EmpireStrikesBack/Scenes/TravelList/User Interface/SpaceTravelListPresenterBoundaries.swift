//
//  SpaceTravelListPresenterBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol SpaceTravelListPresenterOutput: Loadable, ServiceFailureOutput {
  /// Display the trips
  ///
  /// - parameter viewModel: The viewModel that contains the data to display
  func displayTrips(viewModel: TravelModels.List.ViewModel)
}
