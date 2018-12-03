//
//  TripDetailsInteractorTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 02/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest

class TripDetailsInteractorTests: XCTestCase {
  // MARK: - Subject under test
  
  var sut: SpaceTravelDetailsInteractor!
  var workerMock: SpaceTravelWorkerMock!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupTripInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupTripInteractor() {
    self.workerMock = SpaceTravelWorkerMock()
    sut = SpaceTravelDetailsInteractor(travelWorker: self.workerMock)
  }
  
  class TripDetailsPresenterMock: SpaceTravelDetailsInteractorOutput {
    
    // MARK: Method call expectations
    
    var presentFetchedTripCalled = false
    var showLoaderCalled = false
    var hideLoaderCalled = false
    var serviceFailureCalled = false
    var errorType: ServiceErrorType?
    
    func showLoader() {
      self.showLoaderCalled = true
    }
    
    func hideLoader() {
      self.hideLoaderCalled = true
    }
    
    func serviceFailure(error: ServiceErrorType) {
      serviceFailureCalled = true
      errorType = error
    }
    
    // MARK: Spied methods
    
    func presentTripDetails(response: TravelModels.Details.Response) {
      presentFetchedTripCalled = true
    }
  }
  
  // MARK: - Tests
  
  func testMethodSuccessCallExpetations() {
    // Given
    let presenterMock = TripDetailsPresenterMock()
    sut.output = presenterMock
    self.workerMock.isSuccess = true
    self.sut.travelWorker = workerMock
    
    // When
    
    sut.fetchTripDetails()
    
    // Then
    XCTAssert(presenterMock.errorType == .badInput, "Need to have trip Id")
    XCTAssertTrue(presenterMock.serviceFailureCalled, "Need to have trip Id")
   
    // When
    sut.tripIdentifier = 1
    sut.fetchTripDetails()
    // Then
    
    XCTAssert(self.workerMock.trip != nil, "Trip should be nil")
    
    XCTAssert(workerMock.fetchTripDetailsCalled, "fetchAvailableTrips() should ask SpaceTravelWorker to fetch trips")
    
    XCTAssert(presenterMock.presentFetchedTripCalled, "fetchAvailableTrips() should ask presenter to format trips result")
    
    XCTAssert(presenterMock.showLoaderCalled, "fetchAvailableTrips() should ask presenter to show loader")
    
    XCTAssert(presenterMock.hideLoaderCalled, "fetchAvailableTrips() should ask presenter to hide loader")
    
  }
  
  func testMethodFailureCallExpetations() {
    // Given
    let presenterMock = TripDetailsPresenterMock()
    sut.output = presenterMock
    self.workerMock.isSuccess = false
    self.sut.travelWorker = workerMock
    
    // When
    sut.tripIdentifier = 1
    sut.fetchTripDetails()
    
    // Then
    XCTAssert(self.workerMock.trip == nil, "Trip should be nil")
    XCTAssert(workerMock.fetchTripDetailsCalled, "fetchAvailableTrips() should ask SpaceTravelWorker to fetch trips")
    
    XCTAssert(!presenterMock.presentFetchedTripCalled, "fetchAvailableTrips() should ask presenter to format trips result")
    
    XCTAssert(presenterMock.showLoaderCalled, "fetchAvailableTrips() should ask presenter to show loader")
    
    XCTAssert(presenterMock.hideLoaderCalled, "fetchAvailableTrips() should ask presenter to hide loader")
    
    XCTAssert(presenterMock.serviceFailureCalled, "fetchAvailableTrips() should failure")
  }
}
