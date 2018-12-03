//
//  Distance.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

struct Distance: Codable {
  var value: Int
  var unit: String
  
  enum CodingKeys: String, CodingKey {
    case value
    case unit
  }
}
