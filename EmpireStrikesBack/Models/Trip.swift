//
//  Trip.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

struct Trip: Codable {
  var identifier: Int
  var pilot: Pilot
  var duration: TimeInterval
  var distance: Distance
  var pickUp: PickUp
  var dropOff: DropOff
  
  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case pilot
    case duration
    case distance
    case pickUp = "pick_up"
    case dropOff = "drop_off"
  }
}

