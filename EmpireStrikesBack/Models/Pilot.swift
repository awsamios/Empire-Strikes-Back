//
//  Pilot.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

struct Pilot: Codable {
  var name: String
  var avatar: String
  var rating: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case avatar
    case rating
  }
}
