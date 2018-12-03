//
//  TripDetailsViewController.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 02/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest

class TripDetailsViewControllerTests: XCTestCase {
  // MARK: - Subject under test
  
  var sut: SpaceTravelDetailsViewController!
  var window: UIWindow!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupTripDetailsViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupTripDetailsViewController() {
    sut = ModuleFactory.prepareTravelDetailsViewController() as? SpaceTravelDetailsViewController
    XCTAssertNotNil(sut)
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: - Test doubles
  
  class TripDetailsInteractorMock: SpaceTravelDetailsInteractorInput {
    
    var output: SpaceTravelDetailsInteractorOutput?
    
    // MARK: Method call expectations
    
    var fetchTripCalled = false
    
    // MARK: Spied methods
    
    func fetchTripDetails() {
      self.fetchTripCalled = true
      let trip = Trips.darkVadorTrip
      self.output?.presentTripDetails(response: TravelModels.Details.Response(trip: trip))
    }
  }
  
  // MARK: - Tests
  
  func testShouldFetchTripWhenViewDidLoad()
  {
    // Given
    let interactorMock = TripDetailsInteractorMock()
    sut.interactor = interactorMock
    
    // When
    loadView()
    
    // Then
    XCTAssert(interactorMock.fetchTripCalled, "Should fetch trip right after the view did load")
  }
  
  func testShouldDisplayFetchedTrip() {
    
    // Given
    
    let presenter = SpaceTravelDetailsPresenter()
    let interactorMock = TripDetailsInteractorMock()
    interactorMock.output = presenter
    sut.interactor = interactorMock
    presenter.view = sut
    
    // When
    // to trigger viewDidLoad
    _ = sut.view
    
    // Then
    
    XCTAssertEqual(sut.pilotNameLabel.text, "DARK VADOR")
    XCTAssert(sut.arrivalView.subtitleLabel.text == "NABOO")
    XCTAssert(sut.arrivalView.detailsLabel.text == "1:12 PM")
    XCTAssert(sut.departureView.subtitleLabel.text == "YAVIN 4")
    XCTAssert(sut.departureView.detailsLabel.text == "2:12 PM")
    XCTAssert(sut.durationView.subtitleLabel.text == "5:27:07")
    XCTAssert(sut.distanceView.subtitleLabel.text == "2,478,572 KM")
  }
}

