//
//  ModuleFactory.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

class ModuleFactory {
  
  static func presentRootModule() -> UIViewController? {
    
    guard let navigation = AppStoryboard.main.initialViewController as? UINavigationController,
      let viewController = navigation.topViewController as? SpaceTravelListViewController else {
        return nil
    }
    
    let travelWorker = SpaceTravelWorker()
    let interactor = SpaceTravelListInteractor(spaceTravelWorker: travelWorker)
    let presenter = SpaceTravelListPresenter()
    let router = SpaceTravelListRouter()
    router.dataStore = interactor
    
    router.view = viewController
    presenter.view = viewController
    viewController.interactor = interactor
    interactor.output = presenter
    viewController.router = router
    
    return navigation
  }
  
  static func prepareTravelDetailsViewController() -> UIViewController {
    
    let viewController = SpaceTravelDetailsViewController.instantiate(from: .main)
    let interactor = SpaceTravelDetailsInteractor(travelWorker: SpaceTravelWorker())
    let presenter = SpaceTravelDetailsPresenter()
    let router = SpaceTravelDetailsRouter()
    router.dataStore = interactor
    
    router.view = viewController
    presenter.view = viewController
    viewController.interactor = interactor
    interactor.output = presenter
    viewController.router = router
    
    return viewController
  }
}
