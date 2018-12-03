//
//  ListTripsRouterTests.swift
//  EmpireStrikesBackTests
//
//  Created by Samira CHALAL on 03/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

@testable import EmpireStrikesBack
import XCTest


class ListTripsRouterTests: XCTestCase {
  // MARK: - Subject under test
  
  var sut: SpaceTravelListRouter!
  var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupListTripsInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
    window = nil
  }
  
  // MARK: - Test setup
  
  func setupListTripsInteractor() {
    sut = SpaceTravelListRouter()
  }
  
  func loadView(controller: UIViewController) {
    window.rootViewController = controller
    RunLoop.current.run(until: Date())
  }
  
  func testRouter() {
    let interactorMock = SpaceTravelListInteractor(spaceTravelWorker: SpaceTravelWorkerMock())
    self.sut.dataStore = interactorMock
    
    let tripsViewcontrollerMock = SpaceTravelListViewController.instantiate(from: .main)

    let navigation = UINavigationController(rootViewController: tripsViewcontrollerMock)
    tripsViewcontrollerMock.interactor = interactorMock
    tripsViewcontrollerMock.router = sut
    
    let presenter = SpaceTravelListPresenter()
    presenter.view = tripsViewcontrollerMock
    interactorMock.output = presenter
    
    self.loadView(controller: navigation)
    sut.view = tripsViewcontrollerMock
    
    XCTAssertEqual(self.sut.dataStore?.trips.count, interactorMock.trips.count)
    XCTAssertEqual(self.sut.dataStore?.trips.first?.identifier, interactorMock.trips.first?.identifier)
    
    _ = tripsViewcontrollerMock.view
    
    let tableView = tripsViewcontrollerMock.tableView
    let indexPath = IndexPath(row: 0, section: 0)
    tripsViewcontrollerMock.tableView(tableView!, didSelectRowAt: indexPath)
  }
}

