//
//  WeatherDay.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/28/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import Foundation

class WeatherDay: WeatherModel {
   
   var highTemp: String?
   var lowTemp: String?
   var hours: [WeatherHour]?
   
   init(city: String?, conditions:String?, conditionImg:String?, temperature:Int?, dayOfWeek:String?, windSpeed:Int?, windDirection:String?, probOfPrecip:Int?, date: String?, highTemp: String?, lowTemp:String?, hours: [WeatherHour]?) {
      super.init(city: city, conditions: conditions, conditionImg: conditionImg, temperature: temperature, dayOfWeek: dayOfWeek, windSpeed: windSpeed, windDirection: windDirection, probOfPrecip: probOfPrecip,  date: date)
      self.highTemp = highTemp
      self.lowTemp = lowTemp
      self.hours = hours;
   }
   
}
