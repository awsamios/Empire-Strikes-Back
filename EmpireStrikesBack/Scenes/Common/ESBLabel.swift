//
//  ESBLabel.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

@IBDesignable
class ESBLabel: UILabel {
  
  @IBInspectable
  var letterSpacing: Int = 1 {
    didSet {
      self.applyLetterSpacing()
    }
  }
  
  override open var text: String? {
    didSet {
      self.applyLetterSpacing()
    }
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    self.applyLetterSpacing()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.applyLetterSpacing()
  }
  
  fileprivate func applyLetterSpacing() {
    guard let labelText = self.text else {
      return
    }
    
    let attributedString = NSMutableAttributedString(string: labelText)
    attributedString.addAttribute(NSAttributedString.Key.kern,
                                  value: self.letterSpacing,
                                  range: NSRange(location: 0, length: attributedString.length))
    self.attributedText = attributedString
  }
}
