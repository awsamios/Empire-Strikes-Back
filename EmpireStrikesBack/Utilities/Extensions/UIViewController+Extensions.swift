//
//  UIViewController+Extensions.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

extension UIViewController {
  /// The inferred controller's storyboard identifier.
  /// This attribut can be overridden by any UIViewController classes.
  /// - seealso: `AppStoryboard.viewController(withControllerType:)`
  class var storyboardId: String {
    return "\(self)"
  }
  
  /// Instantiate the view controller from the given storyboard.
  /// To find the correct instance of the view controller inside the storyboard, a storyboard identifier inference
  /// if performed. The inferred storyboard identifier is the view controller's class name.
  ///
  /// - parameter from: The app storyboard that contain the controller's instance.
  /// - returns: The UIViewController instance
  ///
  /// - seealso: `storyboardId`
  static func instantiate(from storyboard: AppStoryboard) -> Self {
    return storyboard.viewController(withControllerType: self)
  }
}
