//
//  SpaceTravelListTableViewCell.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 30/11/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

class SpaceTravelListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var pilotImageView: UIImageView!
  @IBOutlet weak var pilotNameLabel: UILabel!
  @IBOutlet weak var pickUpNameLabel: UILabel!
  @IBOutlet weak var dropOffNameLabel: UILabel!
  @IBOutlet weak var ratingView: RatingView!
  @IBOutlet weak var ratingViewHeightConstraint: NSLayoutConstraint!
  
  let ratingViewHeight: CGFloat = 22
  
  func configure(_ displayedData: TravelModels.List.ViewModel.DisplayedTrip) {
    pilotImageView.image = UIImage(named: displayedData.pilotPhotoName)
    pilotNameLabel.text = displayedData.pilotName
    pickUpNameLabel.text = displayedData.pickUpName
    dropOffNameLabel.text = displayedData.dropOffName
    updateRatingView(rating: displayedData.rating, isVisible: displayedData.isRatingVisible)
  }
  
  func updateRatingView(rating: Double, isVisible: Bool) {
    ratingView.setRate(rating, for: .small)
    if isVisible {
      ratingViewHeightConstraint.constant = ratingViewHeight
      ratingView.alpha = 1
    } else {
      ratingViewHeightConstraint.constant = 0
      ratingView.alpha = 0
    }
  }
}
