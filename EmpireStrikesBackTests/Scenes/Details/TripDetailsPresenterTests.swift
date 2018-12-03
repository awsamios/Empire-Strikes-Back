//
//  TripDetailsPresenterTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 02/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest

class TripDetailsPresenterTests: XCTestCase
{
  // MARK: - Subject under test
  
  var sut: SpaceTravelDetailsPresenter!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupTripDetailsPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupTripDetailsPresenter() {
    sut = SpaceTravelDetailsPresenter()
  }
  
  // MARK: - Test doubles
  
  class TripDetailsViewMock: SpaceTravelDetailsPresenterOutput {
    
    
    var displayFetchedTripCalled = false
    var showLoaderCalled = false
    var hideLoaderCalled = false
    var serviceErrorCalled = false
    
    func showLoader() {
      self.showLoaderCalled = true
    }
    
    func hideLoader() {
      self.hideLoaderCalled = true
    }
    
    var viewModel: TravelModels.Details.ViewModel!
    func displayTripDetails(viewModel: TravelModels.Details.ViewModel){
      displayFetchedTripCalled = true
      self.viewModel = viewModel
      
    }
    
    func serviceFailure(error: ServiceErrorType) {
      serviceErrorCalled = true
    }
  }
  
  // MARK: - Tests
  
  func testPresentDataFormat() {
    // Given
    let tripDetailsViewMock = TripDetailsViewMock()
    sut.view = tripDetailsViewMock
    
    // When
    
    let response = TravelModels.Details.Response(trip: Trips.ackbarTrip)
    sut.presentTripDetails(response: response)
    
    // Then
    let displayedTrip = tripDetailsViewMock.viewModel
    
    // test sorting and uppercase
    XCTAssertEqual(displayedTrip?.pilotName, "ADMIRAL ACKBAR")
    
    // test removing first / from pilot photo name
    XCTAssertFalse(displayedTrip?.pilotPhotoName.starts(with: "/") ?? true)
    XCTAssertTrue(displayedTrip?.hasRating == false, "rating should be visible")
    XCTAssert(displayedTrip?.arrival.subtitle == "CORUSCANT")
    XCTAssert(displayedTrip?.arrival.details == "7:35 PM")
    XCTAssert(displayedTrip?.departure.subtitle == "NABOO")
    XCTAssert(displayedTrip?.departure.details == "2:12 PM")
    XCTAssert(displayedTrip?.duration.subtitle == "5:23:47")
    XCTAssert(displayedTrip?.distance.subtitle == "24,785,727,853 KM")
    
    // test ADMIRAL ACKBAR has no rating
    XCTAssertTrue(displayedTrip?.rating == 0)
  }
  
  func testPresentMethodCalls() {
    // Given
    let viewMock = TripDetailsViewMock()
    sut.view = viewMock
    
    // When
    let response = TravelModels.Details.Response(trip: Trips.ackbarTrip)
    sut.presentTripDetails(response: response)
    
    // Then
    XCTAssert(viewMock.displayFetchedTripCalled, "Presenting fetched trip should ask view controller to display it")
  }
}
