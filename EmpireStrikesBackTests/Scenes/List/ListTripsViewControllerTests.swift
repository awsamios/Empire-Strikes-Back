//
//  ListTripsViewControllerTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 02/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest

class ListTripsViewControllerTests: XCTestCase {
  // MARK: - Subject under test
  
  var sut: SpaceTravelListViewController!
  var window: UIWindow!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupListTripsViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupListTripsViewController() {
    sut = SpaceTravelListViewController.instantiate(from: .main)
    XCTAssertNotNil(sut)
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: - Test doubles
  
  class ListTripsRouterMock: SpaceTravelListRouterInput, SpaceTravelListDataPassing {
    var dataStore: SpaceTravelListDataStore?
    
    // MARK: Method call expectations
    
    var routeDetailsCalled = false
    
    var tripId: Int!
    func routeToTripDetails(_ tripId: Int) {
      routeDetailsCalled = true
      self.tripId = tripId
    }
  }
  
  class ListTripsInteractorMock: SpaceTravelListInteractorInput {
    var trips: [Trips] = []
    
    // MARK: Method call expectations
    
    var fetchTripsCalled = false
    
    // MARK: Spied methods
    
    func fetchAvailableTrips() {
      self.fetchTripsCalled = true
    }
  }
  
  class TableViewSpy: UITableView {
    // MARK: Method call expectations
    
    var reloadDataCalled = false
    
    // MARK: Spied methods
    
    override func reloadData() {
      
      reloadDataCalled = true
    }
  }
  
  // MARK: - Tests
  
  func testShouldFetchTripsWhenViewDidLoad() {
    // Given
    let interactorMock = ListTripsInteractorMock()
    sut.interactor = interactorMock
    
    // When
    loadView()
    
    // Then
    XCTAssert(interactorMock.fetchTripsCalled, "Should fetch trips right after the view did load")
  }
  
  func testShouldDisplayFetchedTrips() {
    // Given
    let tableViewSpy = TableViewSpy()
    sut.tableView = tableViewSpy
    
    // When
    let trip2 = TravelModels.List.ViewModel.DisplayedTrip(
      identifier: 1,
      pilotPhotoName: "static/dark-vador",
      pilotName: "DARK VADOR",
      pickUpName: "Yavin 4",
      dropOffName: "Naboo",
      rating: 2,
      isRatingVisible: true)
    
    let trip1 = TravelModels.List.ViewModel.DisplayedTrip(
      identifier: 1,
      pilotPhotoName: "static/boba-fett",
      pilotName: "Boba Fett",
      pickUpName: "Hoth",
      dropOffName: "Tatooine",
      rating: 0,
      isRatingVisible: false)
    
    let displayedTrips = [trip1, trip2]
    let viewModel = TravelModels.List.ViewModel(displayedTrips: displayedTrips)
    sut.displayTrips(viewModel: viewModel)
    
    // Then
    XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched trips should reload the table view")
    
    XCTAssertEqual(self.sut.trips.count, 2, "We should have 2 trips")
    
    // Given
    let tableView = sut.tableView
    
    // When
    let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 1)
    
    // Then
    XCTAssertEqual(numberOfRows, 2, "The number of table view rows should be 2")
    XCTAssertEqual(sut.trips.count, numberOfRows, "The number of table view rows should be 2")
  }
  
  func testShouldConfigureTableViewCellToDisplayTrip() {
    // Given
    _ = sut.view
    let tableView = sut.tableView
    
    let trip1 = TravelModels.List.ViewModel.DisplayedTrip(
      identifier: 1,
      pilotPhotoName: "static/boba-fett",
      pilotName: "BOBA FETT",
      pickUpName: "Hoth",
      dropOffName: "Tatooine",
      rating: 0,
      isRatingVisible: false)
    
    let trip2 = TravelModels.List.ViewModel.DisplayedTrip(
      identifier: 1,
      pilotPhotoName: "static/dark-vador",
      pilotName: "DARK VADOR",
      pickUpName: "Yavin 4",
      dropOffName: "Naboo",
      rating: 2,
      isRatingVisible: true)
    
    let viewModel = TravelModels.List.ViewModel(displayedTrips: [trip1, trip2])
    sut.displayTrips(viewModel: viewModel)
    
    // When
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = sut.tableView(tableView!, cellForRowAt: indexPath) as? SpaceTravelListTableViewCell
    
    
    // Then
    
    XCTAssertNotNil(cell)
    XCTAssertEqual(tableView?.numberOfRows(inSection: 0), sut.trips.count, "number of rows should 2")
    XCTAssertEqual(
      cell?.dropOffNameLabel.text, "Tatooine",
      "A properly configured table view cell should display the dropOff name")
    
    XCTAssertEqual(
      cell?.pilotNameLabel.text, "BOBA FETT",
      "A properly configured table view cell should display the pilot name")
  }
  
  func testRouting() {
    // Given
    
    let routerMock = ListTripsRouterMock()
    sut.router = routerMock
    
    _ = sut.view
    let tableView = sut.tableView
    
    let trip1 = TravelModels.List.ViewModel.DisplayedTrip(
      identifier: 1,
      pilotPhotoName: "static/boba-fett",
      pilotName: "BOBA FETT",
      pickUpName: "Hoth",
      dropOffName: "Tatooine",
      rating: 0,
      isRatingVisible: false)
    
    let viewModel = TravelModels.List.ViewModel(displayedTrips: [trip1])
    sut.displayTrips(viewModel: viewModel)
    
    // When
    let indexPath = IndexPath(row: 0, section: 0)
    sut.tableView(tableView!, didSelectRowAt: indexPath)
    // Then
    
    XCTAssertTrue(routerMock.routeDetailsCalled, "When selecting cell, view should call route to navigate to details")
    
    XCTAssertEqual(routerMock.tripId, 1)
  }
}
