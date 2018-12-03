//
//  ListTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest

class SpaceTravelWorkerMock: SpaceTravelProvider {
  
  var fetchTripListCalled = false
  var fetchTripDetailsCalled = false
  var isSuccess = true
  var trips: [Trip] = [Trips.darkVadorTrip, Trips.darkVadorTrip]
  var trip: Trip?
  
  func fetchSpaceTravelList(completion: SpaceTravelResultCompletion?) {
    fetchTripListCalled = true
  
    if isSuccess {
      completion?(SpaceTravelResult.success(self.trips))
    }
    else {
      completion?(SpaceTravelResult.failure(.technical))
    }
  }
  
  func fetchTripDetails(_ identifier: Int, completion: SpaceTravelDetailsResultCompletion?) {
    fetchTripDetailsCalled = true
    if isSuccess {
      let trip = self.trips.first(where: { $0.identifier == identifier })
      self.trip = trip
      
      completion?(SpaceTravelDetailsResult.success(trip))
    }
    else {
      completion?(SpaceTravelDetailsResult.failure(.technical))
    }
  }
}

class ListTripsInteractorTests: XCTestCase {
  // MARK: - Subject under test
  
  var sut: SpaceTravelListInteractor!
  var workerMock: SpaceTravelWorkerMock!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupListTripsInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupListTripsInteractor() {
    self.workerMock = SpaceTravelWorkerMock()
    sut = SpaceTravelListInteractor(spaceTravelWorker: self.workerMock)
  }
  
  class ListTripPresenterMock: SpaceTravelListInteractorOutput {
    // MARK: Method call expectations
    
    var presentFetchedTripsCalled = false
    var showLoaderCalled = false
    var hideLoaderCalled = false
    var serviceFailureCalled = false
    
    func showLoader() {
      self.showLoaderCalled = true
    }
    
    func hideLoader() {
      self.hideLoaderCalled = true
    }
    
    func serviceFailure(error: ServiceErrorType) {
      self.serviceFailureCalled = true
    }
    
    // MARK: Spied methods
    func presentTrips(response: TravelModels.List.Response) {
      presentFetchedTripsCalled = true
    }
  }
  
  class TripsWorkerFailureMock: SpaceTravelProvider {
    // MARK: Method call expectations
    
    var fetchTripListCalled = false
    
    func fetchSpaceTravelList(completion: SpaceTravelResultCompletion?) {
      self.fetchTripListCalled = true
      completion?(SpaceTravelResult.failure(.noData))
    }
    
    func fetchTripDetails(_ identifier: Int, completion: SpaceTravelDetailsResultCompletion?) {}
  }
  
  
  // MARK: - Tests
  
  func testMethodSuccessCallExpetations() {
    // Given
    let presenterMock = ListTripPresenterMock()
    sut.output = presenterMock
    self.workerMock.isSuccess = true
    sut.spaceTravelWorker = self.workerMock
    
    // When
    
    sut.fetchAvailableTrips()
    
    // Then
    XCTAssertTrue(sut.trips.count == 2, "We should have 1 trip")
    
    XCTAssert(workerMock.fetchTripListCalled, "fetchAvailableTrips() should ask SpaceTravelWorker to fetch trips")
    
    XCTAssert(presenterMock.presentFetchedTripsCalled, "fetchAvailableTrips() should ask presenter to format trips result")
    
    XCTAssert(presenterMock.showLoaderCalled, "fetchAvailableTrips() should ask presenter to show loader")
    
    XCTAssert(presenterMock.hideLoaderCalled, "fetchAvailableTrips() should ask presenter to hide loader")
    
    XCTAssert(!presenterMock.serviceFailureCalled, "fetchAvailableTrips() should succeed")
  }
  
  func testMethodFailureCallExpetations() {
    // Given
    let presenterMock = ListTripPresenterMock()
    sut.output = presenterMock
    self.workerMock.isSuccess = false
    self.sut.spaceTravelWorker = workerMock
    
    // When
    
    sut.fetchAvailableTrips()
    
    XCTAssertTrue(sut.trips.isEmpty, "We should have no trip in error case")
    
    // Then
    XCTAssert(workerMock.fetchTripListCalled, "fetchAvailableTrips() should ask SpaceTravelWorker to fetch trips")
    
    XCTAssert(!presenterMock.presentFetchedTripsCalled, "fetchAvailableTrips() should ask presenter to format trips result")
    
    XCTAssert(presenterMock.showLoaderCalled, "fetchAvailableTrips() should ask presenter to show loader")
    
    XCTAssert(presenterMock.hideLoaderCalled, "fetchAvailableTrips() should ask presenter to hide loader")
    
    XCTAssert(presenterMock.serviceFailureCalled, "fetchAvailableTrips() should failure")
  }
}
