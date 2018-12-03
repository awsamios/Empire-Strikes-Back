//
//  SpaceTraveDetailsPresenter.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class SpaceTravelDetailsPresenter {
  var view: SpaceTravelDetailsPresenterOutput?
}

extension SpaceTravelDetailsPresenter: SpaceTravelDetailsInteractorOutput {
  func presentTripDetails(response: TravelModels.Details.Response) {
    
    typealias Entry = TravelModels.Details.ViewModel.DislayedTripEntry
    
    var trip = response.trip
    
    let departure = Entry(
      title: "travel_details_departure_title".localized,
      subtitle: trip.pickUp.name.uppercased(),
      details: trip.pickUp.date.readableDateTime)
    
    let arrival = Entry(
      title: "travel_details_arrival_title".localized,
      subtitle: trip.dropOff.name.uppercased(),
      details: trip.dropOff.date.readableDateTime)
    
    let duration = Entry(
      title: "travel_details_duration_title".localized,
      subtitle: trip.duration.readbleDateTime ?? "",
      details: nil)
    
    let distance = Entry(
      title: "travel_details_distance_title".localized,
      subtitle: "\(trip.distance.value.formattedWithSeparator ?? "") \(trip.distance.unit.uppercased())",
      details: nil)
    
    // remove the first / to match the path of the avatar image static/{imageName}
    trip.pickUp.picture.removeFirstChar("/")
    trip.dropOff.picture.removeFirstChar("/")
    trip.pilot.avatar.removeFirstChar("/")
    
    let viewModel = TravelModels.Details.ViewModel(
      departurePlanetPhotoName: trip.pickUp.picture + "-large",
      arrivalPlanetPhotoName: trip.dropOff.picture + "-large",
      departure: departure,
      arrival: arrival,
      distance: distance,
      duration: duration,
      pilotName: trip.pilot.name.uppercased(),
      pilotPhotoName: trip.pilot.avatar + "-large",
      hasRating: trip.pilot.rating != 0,
      rating: trip.pilot.rating)
    
    view?.displayTripDetails(viewModel: viewModel)
    
  }
  
  func showLoader() {
    view?.showLoader()
  }
  
  func hideLoader() {
    view?.hideLoader()
  }
  
  func serviceFailure(error: ServiceErrorType) {
    view?.serviceFailure(error: error)
  }
}

