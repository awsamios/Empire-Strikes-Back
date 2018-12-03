//
//  TripsTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation
@testable import EmpireStrikesBack

struct Trips
{
  
  //    {
  //    "id": 1,
  //    "pilot": {
  //    "name": "Dark Vador",
  //    "avatar": "/static/dark-vador.png",
  //    "rating": 5
  //    },
  //    "distance": {
  //    "value": 2478572,
  //    "unit": "km"
  //    },
  //    "duration": 19427000,
  //    "pick_up": {
  //    "name": "Yavin 4",
  //    "picture": "/static/yavin-4.png",
  //    "date": "2017-12-09T14:12:51Z"
  //    },
  //    "drop_off": {
  //    "name": "",
  //    "picture": "",
  //    "date": "2017-12-09T19:35:51Z"
  //    }
  //    }
  
  static let darkVadorTrip = Trip(
    identifier: 1,
    pilot: Pilot(name: "Dark Vador", avatar: "/static/dark-vador.png", rating: 5),
    duration: 19627000,
    distance: Distance(value: 2478572, unit: "km"),
    pickUp: PickUp(name: "Yavin 4", picture: "/static/yavin-4.png", date: "2017-12-09T14:12:51Z".isoDate ?? Date()),
    dropOff: DropOff(name: "Naboo", picture: "/static/naboo.png", date: "2017-12-09T13:12:51Z".isoDate ?? Date()))
  
  static let ackbarTrip = Trip(
    identifier: 1,
    pilot: Pilot(name: "Admiral Ackbar", avatar: "/static/admiral-ackbar.png", rating: 0),
    duration: 19427000,
    distance: Distance(value: 24785727853, unit: "km"),
    pickUp: PickUp(name: "Naboo", picture: "/static/naboo.png", date: "2017-12-09T14:12:51Z".isoDate ?? Date()),
    dropOff: DropOff(name: "Coruscant", picture: "/static/coruscant.png", date: "2017-12-09T19:35:51Z".isoDate ?? Date()))
  
}
