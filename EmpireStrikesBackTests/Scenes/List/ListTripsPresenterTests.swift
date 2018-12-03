//
//  ListTripsPresenterTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 02/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest

class ListTripsPresenterTests: XCTestCase {
  // MARK: - Subject under test
  
  var sut: SpaceTravelListPresenter!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupListTripsPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupListTripsPresenter() {
    sut = SpaceTravelListPresenter()
  }
  
  // MARK: - Test doubles
  
  class ListTripsViewMock: SpaceTravelListPresenterOutput {
    
    var displayFetchedTripsCalled = false
    var showLoaderCalled = false
    var hideLoaderCalled = false
    var serviceErrorCalled = false
    
    func showLoader() {
      self.showLoaderCalled = true
    }
    
    func hideLoader() {
      self.hideLoaderCalled = true
    }
    
    var viewModel: TravelModels.List.ViewModel!
    func displayTrips(viewModel: TravelModels.List.ViewModel){
      displayFetchedTripsCalled = true
      self.viewModel = viewModel
      
    }
    
    func serviceFailure(error: ServiceErrorType) {
      serviceErrorCalled = true
    }
  }
  
  // MARK: - Tests
  
  func testPresentDataFormat() {
    // Given
    let listTripsSpy = ListTripsViewMock()
    sut.view = listTripsSpy
    
    // When
    
    let response = TravelModels.List.Response(trips: [Trips.darkVadorTrip, Trips.ackbarTrip])
    sut.presentTrips(response: response)
    
    // Then
    let displayedTrips = listTripsSpy.viewModel.displayedTrips
    
    // test number of items:
    XCTAssertEqual(displayedTrips.count, 2)
    
    // test sorting and uppercase
    let firstTrip = displayedTrips.first
    XCTAssertEqual(firstTrip?.pilotName, "ADMIRAL ACKBAR")
    
    let lastTrip = displayedTrips.last
    XCTAssertEqual(lastTrip?.pilotName, "DARK VADOR")
    
    // test removing first / from pilot photo name
    XCTAssertFalse(firstTrip?.pilotPhotoName.starts(with: "/") ?? true)
    
    // test DARK VADOR has rating
    XCTAssertTrue(lastTrip?.isRatingVisible == true, "rating should be visible")
    
    // test ADMIRAL ACKBAR has no rating
    XCTAssertTrue(firstTrip?.isRatingVisible == false, "rating should be invisible")
  }
  
  func testPresentMethodCalls() {
    // Given
    let viewMock = ListTripsViewMock()
    sut.view = viewMock
    
    // When
    let response = TravelModels.List.Response(trips: [Trips.darkVadorTrip, Trips.ackbarTrip])
    sut.presentTrips(response: response)
    
    // Then
    XCTAssert(viewMock.displayFetchedTripsCalled, "Presenting fetched trips should ask view controller to display them")
    
   XCTAssertTrue(viewMock.viewModel.displayedTrips.count == 2, "We should have 2 trips")
  }
}
