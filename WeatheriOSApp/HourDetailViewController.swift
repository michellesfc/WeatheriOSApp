//
//  HourDetailViewController.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 11/5/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import UIKit

class HourDetailViewController: UIViewController {


   @IBOutlet weak var navigationBar: UINavigationItem!
   @IBOutlet weak var hourLabel: UILabel!
   @IBOutlet weak var temperatureLabel: UILabel!
   @IBOutlet weak var windSpeedLabel: UILabel!
   @IBOutlet weak var popLabel: UILabel!
   @IBOutlet weak var UVILabel: UILabel!
   @IBOutlet weak var heatIndexLabel: UILabel!
   @IBOutlet weak var windChillLabel: UILabel!
   @IBOutlet weak var conditionLabel: UILabel!
   @IBOutlet weak var iconLabel: UILabel!
   
   var hour:WeatherHour = WeatherHour()
   
   func setHourDetailLabels() {
      
      let date = hour.date!
      let idx = date.range(of: "on")?.upperBound
      navigationBar.title = hour.dayOfWeek! + ", " + hour.date!.substring(from: idx!)
      
      hourLabel.text = hour.hour!
      iconLabel.text = hour.conditionImg!
      conditionLabel.text = hour.conditions!
      temperatureLabel.text = "Temperature: " + String(hour.temperature!) + "°F"
      windSpeedLabel.text = "Wind Speed: " + String(hour.windSpeed!) + " mph"
      popLabel.text = "Probability of Precipitation: " + String(hour.probOfPrecip!) + "%"
      UVILabel.text = "UVI: \(hour.UVI!)"
      
      if(hour.heatIndex! != -9999 && hour.heatIndex! != -999) {
         heatIndexLabel.text = "Heat Index: \(hour.heatIndex!)"
      }
      else {
         heatIndexLabel.text = "Heat Index: n/a"
      }
      
      if(hour.windChill! != -9999 && hour.windChill! != -999) {
         windChillLabel.text = "Wind Chill: \(hour.windChill!)"
      }
      else {
         windChillLabel.text = "Wind Chill: n/a"
      }
   }
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      setHourDetailLabels()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

}
