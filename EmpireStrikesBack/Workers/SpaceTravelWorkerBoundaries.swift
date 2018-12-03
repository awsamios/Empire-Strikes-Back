//
//  SpaceTravelWorkerBoundaries.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

typealias SpaceTravelResult = ServiceResultObject<[Trip], ServiceErrorType>
typealias SpaceTravelResultCompletion = (SpaceTravelResult) -> Void

typealias SpaceTravelDetailsResult = ServiceResultObject<Trip, ServiceErrorType>
typealias SpaceTravelDetailsResultCompletion = (SpaceTravelDetailsResult) -> Void

protocol SpaceTravelProvider: class {
  
  /// Fetch list of space travels
  ///
  /// - parameter completion: the completion to execute when data fetched or error occured
  func fetchSpaceTravelList(completion: SpaceTravelResultCompletion?)
  
  /// Fetch trip details for the given trip identifier
  ///
  /// - parameter identifier: the identifier of the trip
  /// - parameter completion: the completion to execute when data fetched or error occured
  func fetchTripDetails(_ identifier: Int, completion: SpaceTravelDetailsResultCompletion?)
}
