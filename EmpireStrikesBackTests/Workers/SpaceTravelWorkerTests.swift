//
//  NetworkTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import XCTest
@testable import EmpireStrikesBack

class NetworkListMock: NetworkProvider {
  var executeMethodExecuted = false
  
  required init(environment: Environment) {}
  
  func execute(_ request: RequestInput, completion: NetworkCompletion?) {
    executeMethodExecuted = true
    
    let trips =
      """
    [{
      \"id\": 1,
      \"pilot\": {
      \"name\": \"Admiral Ackbar\",
      \"avatar\": \"/static/admiral-ackbar.png\",
      \"rating\": 0
      },
      \"drop_off\": {
        \"name\": \"Coruscant\",
      \"picture\": \"/static/coruscant.png\",
      \"date\": \"2017-12-09T19:35:51Z\"
      },
      \"pick_up\": {
        \"name\": \"Naboo\",
        \"picture\": \"/static/naboo.png\",
        \"date\": \"2017-12-09T19:35:51Z\"
      },
      \"distance\": {
      \"value\": 24785727853,
      \"unit\": \"km\"
      },
      \"duration\": 19427000
    }]
    """
    
    if let data =  trips.data(using: .utf8) {
      completion?(ServiceResultObject.success(data))
    }
    else {
      completion?(ServiceResultObject.failure(ServiceErrorType.noData))
    }
  }
}

class NetworkDetailsMock: NetworkProvider {
  var executeMethodExecuted = false
  
  required init(environment: Environment) {}
  
  func execute(_ request: RequestInput, completion: NetworkCompletion?) {
    executeMethodExecuted = true
    
    let trips =
    """
    {
      \"id\": 1,
      \"pilot\": {
      \"name\": \"Admiral Ackbar\",
      \"avatar\": \"/static/admiral-ackbar.png\",
      \"rating\": 0
      },
      \"drop_off\": {
        \"name\": \"Coruscant\",
      \"picture\": \"/static/coruscant.png\",
      \"date\": \"2017-12-09T19:35:51Z\"
      },
      \"pick_up\": {
        \"name\": \"Naboo\",
        \"picture\": \"/static/naboo.png\",
        \"date\": \"2017-12-09T11:35:51Z\"
      },
      \"distance\": {
      \"value\": 24785727853,
      \"unit\": \"km\"
      },
      \"duration\": 19427000
    }
    """
    
    if let data =  trips.data(using: .utf8) {
      completion?(ServiceResultObject.success(data))
    }
    else {
      completion?(ServiceResultObject.failure(ServiceErrorType.noData))
    }
  }
}

class SpaceTravelListWorkerTest: XCTestCase {
  
  // MARK: - Subject under test
  var sut: SpaceTravelWorker!
  var networkMock: NetworkListMock!
  var trips: [Trip]!
  
  // MARK: - Test lifecycle
  override func setUp() {
    super.setUp()
    setupWorker()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupWorker() {
    self.sut = SpaceTravelWorker()
    networkMock = NetworkListMock(environment: Environment("", name: ""))
    sut.networkService = networkMock
  }
  
  func testTripsFunctionsCall() {
    var serviceResult: SpaceTravelResult?
    let expect = expectation(description: "Wait for fetchTrips() to return")
    
    self.sut.fetchSpaceTravelList(completion: { result  in
      serviceResult = result
      expect.fulfill()
    })
    
    waitForExpectations(timeout: 2)
    XCTAssertTrue(serviceResult?.isSuccess ?? false)
    XCTAssertTrue(serviceResult?.value?.count == 1)
    XCTAssertTrue(serviceResult?.value?.first?.pickUp.date.readableDateTime == "7:35 PM")
    XCTAssertTrue(self.networkMock.executeMethodExecuted, "interactor shoud call ")
  }
}

class SpaceTravelDetailsWorkerTest: XCTestCase {
  
  // MARK: - Subject under test
  var sut: SpaceTravelWorker!
  var networkMock: NetworkDetailsMock!
  
  // MARK: - Test lifecycle
  override func setUp() {
    super.setUp()
    setupWorker()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupWorker() {
    self.sut = SpaceTravelWorker()
    networkMock = NetworkDetailsMock(environment: Environment("", name: ""))
    sut.networkService = networkMock
  }
  
  func testTripFunctionsCall() {
    var serviceResult: SpaceTravelDetailsResult?
    let expect = expectation(description: "Wait for fetchTrips() to return")
    
    self.sut.fetchTripDetails(1) { result  in
      serviceResult = result
      expect.fulfill()
    }
    
    waitForExpectations(timeout: 2)
    XCTAssertTrue(serviceResult?.isSuccess ?? false)
    XCTAssertTrue(serviceResult?.value != nil)
    XCTAssertEqual(serviceResult?.value?.pickUp.date.readableDateTime, "11:35 AM")
    XCTAssertTrue(self.networkMock.executeMethodExecuted, "interactor shoud call worker")
  }
}
