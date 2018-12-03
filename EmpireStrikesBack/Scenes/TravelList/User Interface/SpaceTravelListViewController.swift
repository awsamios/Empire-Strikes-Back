//
//  SpaceTravelListViewController.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

class SpaceTravelListViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  /// MARK: - Properties
  /// See init in Factory
  var interactor: SpaceTravelListInteractorInput?
  var router: (SpaceTravelListRouterInput & SpaceTravelListDataPassing)?
  var trips: [TravelModels.List.ViewModel.DisplayedTrip] = []
  
  private let cellIdentifier = "travelCellIdentifier"
  
  /// MARK: - Life Cyle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    interactor?.fetchAvailableTrips()
  }
  
  func setupUI() {
    tableView.estimatedRowHeight = 88
    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
    title = "space_travels_page_title".localized
  }
}

/// MARK: - UITableViewDelegate, UITableViewDataSource
extension SpaceTravelListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trips.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier, for: indexPath) as? SpaceTravelListTableViewCell else {
        return UITableViewCell()
    }
    
    cell.configure(trips[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // Stormtrooper tap on entry in the list, route to details
    let selectedTrip = trips[indexPath.row]
    router?.routeToTripDetails(selectedTrip.identifier)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension SpaceTravelListViewController: SpaceTravelListPresenterOutput {
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
  
//  func showLoader() {
//    
//  }
//  
//  func hideLoader() {
//    
//  }
  
  func displayTrips(viewModel: TravelModels.List.ViewModel) {
    self.trips = viewModel.displayedTrips
    self.tableView.reloadData()
  }
}
