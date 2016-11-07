//
//  HourTableViewCell.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 11/4/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import UIKit

class HourTableViewCell: UITableViewCell {
   
   @IBOutlet weak var hourLabel: UILabel!
   @IBOutlet weak var windLabel: UILabel!
   @IBOutlet weak var popLabel: UILabel!
   @IBOutlet weak var tempLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   
}
