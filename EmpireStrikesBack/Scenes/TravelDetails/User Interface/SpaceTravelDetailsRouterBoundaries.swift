//
//  SpaceTravelListRouterBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

protocol SpaceTravelDetailsDataPassing {
  var dataStore: SpaceTravelDetailsDataStore? { get }
}

protocol SpaceTravelDetailsRouterInput: class {}
