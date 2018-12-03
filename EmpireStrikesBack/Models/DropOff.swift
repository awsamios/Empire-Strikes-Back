//
//  DropOff.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 29/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

struct DropOff: Codable {
  var name: String
  var picture: String
  var date: Date
  
  enum CodingKeys: String, CodingKey {
    case name
    case picture
    case date
  }
}
