//
//  Loadable.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

protocol Loadable: class {
  func showLoader()
  func hideLoader()
}

extension Loadable where Self: UIViewController {
  func showLoader() {
  //  let spinnerView = UIView(frame: self.view.bounds)
  //  spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicator.startAnimating()
    activityIndicator.center = self.view.center
    
    DispatchQueue.main.async {
      //spinnerView.addSubview(ai)
      self.view.addSubview(activityIndicator)
      self.view.bringSubviewToFront(activityIndicator)
    }
  }
  
  func hideLoader() {
    DispatchQueue.main.async {
      for view in self.view.subviews where view is UIActivityIndicatorView {
        view.removeFromSuperview()
        break
      }
    }
  }
}
