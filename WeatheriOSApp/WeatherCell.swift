//
//  WeatherCell.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 11/3/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
   

   @IBOutlet weak var weekdayLabel: UILabel!
   @IBOutlet weak var iconLabel: UILabel!
   @IBOutlet weak var lowLabel: UILabel!
   @IBOutlet weak var highLabel: UILabel!
   @IBOutlet weak var popLabel: UILabel!
   @IBOutlet weak var conditionLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
}

