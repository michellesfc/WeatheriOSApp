//
//  WeatherModel.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/28/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import Foundation

class WeatherModel {
   
   var city:String?
   var conditions:String?
   var conditionImg:String?
   var temperature:Int?
   var dayOfWeek:String?
   var windSpeed:Int?
   var windDirection:String?
   var probOfPrecip:Int?
   var date: String?
   
   init() {
   }
   
   init(city: String?, conditions:String?, conditionImg:String?, temperature:Int?, dayOfWeek:String?, windSpeed:Int?, windDirection:String?, probOfPrecip:Int?, date: String?) {
      
      self.city = city;
      self.conditions = conditions
      self.conditionImg = conditionImg
      self.temperature = temperature
      self.dayOfWeek = dayOfWeek
      self.windSpeed = windSpeed
      self.windDirection = windDirection
      self.probOfPrecip = probOfPrecip
      self.date = date
   }
}
