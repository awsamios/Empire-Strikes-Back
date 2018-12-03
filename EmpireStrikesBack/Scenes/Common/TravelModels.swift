//
//  TravelModels.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

enum TravelModels {
  enum List {
    struct Response {
      var trips: [Trip]
    }
    
    struct ViewModel {
      struct DisplayedTrip {
        var identifier: Int
        var pilotPhotoName: String
        var pilotName: String
        var pickUpName: String
        var dropOffName: String
        var rating: Double
        var isRatingVisible: Bool
      }
      
      var displayedTrips: [DisplayedTrip]
    }
  }
  
  enum Details {
    struct Response {
      var trip: Trip
    }
    
    struct ViewModel {
      
      struct DislayedTripEntry {
        var title: String
        var subtitle: String
        var details: String?
      }
      
      var departurePlanetPhotoName: String
      var arrivalPlanetPhotoName: String
      var departure: DislayedTripEntry
      var arrival: DislayedTripEntry
      var distance: DislayedTripEntry
      var duration: DislayedTripEntry
      var pilotName: String
      var pilotPhotoName: String
      var hasRating: Bool
      var rating: Double
    }
  }
}
