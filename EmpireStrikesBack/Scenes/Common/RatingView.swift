//
//  RatingView.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

enum RatingViewType: String {
  case small, large
}

class RatingView: UIView {
  let maxRatingStars = 5
  private var starsList: [UIImageView] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func draw(ratingViewType: RatingViewType) {
    
    var tmpArray: [UIImageView] = []
    guard let image = UIImage(named: ratingViewType.rawValue + "-empty-star") else {
      return
    }
    
    // setup image width and height
    let starWidth: CGFloat = image.size.width
    let starHeight: CGFloat = image.size.height
    let trailing: CGFloat = (ratingViewType == .small) ? 2 : 4
    
    // Init RatingView frame size
    self.frame = CGRect(
      x: self.frame.origin.x,
      y: self.frame.origin.y,
      width: (starWidth + trailing) * CGFloat(maxRatingStars),
      height: starHeight)
    
    
    for index in 0..<maxRatingStars {
      let imageView = UIImageView(image: image)
      tmpArray.append(imageView)
      
      tmpArray.last?.frame = CGRect(x: CGFloat(index) * (starWidth + trailing), y: 0, width: starWidth, height: starHeight)
      
      if let imageView = tmpArray.last {
        self.addSubview(imageView)
      }
    }
    
    self.starsList = tmpArray
    self.backgroundColor = .clear
  }
  
  func setRate(_ rate: Double, for ratingViewType: RatingViewType) {
    
    draw(ratingViewType: ratingViewType)
    
    // set full stars
    let nbFilledStars: Int = Int(round(rate))
    for index in 0..<nbFilledStars {
      if let image = UIImage(named: ratingViewType.rawValue + "-filled-star") {
        self.starsList[index].image = image
      }
    }
    
    // set empty stars
    for index in nbFilledStars..<maxRatingStars {
      if let image = UIImage(named: ratingViewType.rawValue + "-empty-star") {
        self.starsList[index].image = image
      }
    }
  }
}
