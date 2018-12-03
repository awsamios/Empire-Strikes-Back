//
//  SpaceTravelDetailsView.swift
//  EmpireStrikesBack
//
//  Created by Samira AOUINE on 01/12/2018.
//  Copyright © 2018 ACME. All rights reserved.
//

import UIKit

class SpaceTravelDetailsView: UIView {
  
  @IBOutlet weak var detailsHeightConstaint: NSLayoutConstraint!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: ESBLabel!
  @IBOutlet weak var detailsLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    self.loadViewFromXib()
  }
  
  func configure(_ data: TravelModels.Details.ViewModel.DislayedTripEntry) {
    self.titleLabel.text = data.title
    self.subtitleLabel.text = data.subtitle
    self.detailsLabel.text = data.details
    self.detailsHeightConstaint.isActive = data.details == nil
  }
}
