//
//  SpaceTravelDetailsViewController.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

class SpaceTravelDetailsViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var depaturePlanetImageView: UIImageView!
  @IBOutlet weak var arrivalPlanetImageView: UIImageView!
  @IBOutlet weak var pilotImageView: UIImageView!
  @IBOutlet weak var pilotNameLabel: ESBLabel!
  @IBOutlet weak var departureView: SpaceTravelDetailsView!
  @IBOutlet weak var arrivalView: SpaceTravelDetailsView!
  @IBOutlet weak var distanceView: SpaceTravelDetailsView!
  @IBOutlet weak var durationView: SpaceTravelDetailsView!
  @IBOutlet weak var ratingView: RatingView!
  @IBOutlet weak var noRatingLabel: ESBLabel!
  
  /// MARK: - Properties
  /// See init in Factory
  var interactor: SpaceTravelDetailsInteractorInput?
  var router: (SpaceTravelDetailsRouterInput & SpaceTravelDetailsDataPassing)?
  var trips: [TravelModels.List.ViewModel.DisplayedTrip] = []
  
  private let cellIdentifier = "detailsCellIdentifier"
  
  /// MARK: - Life Cyle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    interactor?.fetchTripDetails()
  }
  
  func setup() {
    noRatingLabel.text = "travel_details_no_rating_message".localized
  }
  
  private func updateRatingDisplay(_ hasRating: Bool) {
    ratingView.alpha = hasRating ? 1 : 0
    noRatingLabel.alpha = !hasRating ? 1 : 0
  }
}

extension SpaceTravelDetailsViewController: SpaceTravelDetailsPresenterOutput {
  func serviceFailure(error: ServiceErrorType) {
    var message = ""
    switch error {
    case .noData:
      message = "no_data_error_message".localized
      
    case .badInput:
      message = "bad_input_error_message".localized
      
    default:
      message = "common_error_message".localized
    }
    
    let alertController = UIAlertController(title: "common_error_title".localized, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction.init(title: "common_ok".localized, style: .default, handler: nil)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func displayTripDetails(viewModel: TravelModels.Details.ViewModel) {
    
    depaturePlanetImageView.image = UIImage(named: viewModel.departurePlanetPhotoName)
    arrivalPlanetImageView.image = UIImage(named: viewModel.arrivalPlanetPhotoName)
    pilotImageView.image = UIImage(named: viewModel.pilotPhotoName)
    pilotNameLabel.text = viewModel.pilotName
    departureView.configure(viewModel.departure)
    arrivalView.configure(viewModel.arrival)
    distanceView.configure(viewModel.distance)
    durationView.configure(viewModel.duration)
    ratingView.setRate(viewModel.rating, for: .large)
    updateRatingDisplay(viewModel.hasRating)
  }
}

