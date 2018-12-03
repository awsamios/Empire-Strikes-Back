//
//  ApplicationTheme.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

protocol Theme {
  func apply()
}

class ApplicationTheme: Theme {
  func apply() {
    NavigationBarTheme().apply()
  }
}

class NavigationBarTheme: Theme {
  func apply() {
    let appearance = UINavigationBar.appearance()
    appearance.tintColor = .white
    appearance.barTintColor = .black
    appearance.isTranslucent = false
    appearance.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold) as Any,
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.kern: 3]
  }
}

