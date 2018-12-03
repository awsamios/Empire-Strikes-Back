//
//  SpaceTravelListPresenter.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class SpaceTravelListPresenter {
  var view: SpaceTravelListPresenterOutput? 
}

extension SpaceTravelListPresenter: SpaceTravelListInteractorOutput {
  func presentTrips(response: TravelModels.List.Response) {
    
    // first sort the trips by pilot name
    let sortedTrips = response.trips.sorted { $0.pilot.name < $1.pilot.name }
    let displyedTrips = sortedTrips.compactMap { item -> TravelModels.List.ViewModel.DisplayedTrip in
      
      var newItem = item
      // remove the first / to match the path of the avatar image static/{imageName}
      newItem.pilot.avatar.removeFirstChar("/")
      
      return TravelModels.List.ViewModel.DisplayedTrip(
        identifier: newItem.identifier,
        pilotPhotoName: newItem.pilot.avatar,
        pilotName: newItem.pilot.name.uppercased(),
        pickUpName: newItem.pickUp.name,
        dropOffName: newItem.dropOff.name,
        rating: newItem.pilot.rating,
        isRatingVisible: newItem.pilot.rating != 0)
    }
    
    let viewController = TravelModels.List.ViewModel(displayedTrips: displyedTrips)
    view?.displayTrips(viewModel: viewController)
  }
  
  func showLoader() {
    view?.showLoader()
  }
  
  func hideLoader() {
    view?.hideLoader()
  }
  
  func serviceFailure(error: ServiceErrorType) {
    
  }
}
