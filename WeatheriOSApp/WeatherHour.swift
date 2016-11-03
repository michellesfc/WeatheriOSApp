//
//  WeatherHour.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/28/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import Foundation

class WeatherHour: WeatherModel {
   var hour:Int?
   var UVI: Int?
   var heatIndex: Int?
   var windChill: Int?
   
   init(city: String?, conditions:String?, conditionImg:String?, temperature:Int?, dayOfWeek:String?, windSpeed:Int?, windDirection:String?, probOfPrecip:Int?, date: String?, hour: Int?, UVI: Int?, heatIndex:Int?, windChill:Int?) {
      super.init(city: city, conditions: conditions, conditionImg: conditionImg, temperature: temperature, dayOfWeek: dayOfWeek, windSpeed: windSpeed, windDirection: windDirection, probOfPrecip: probOfPrecip,  date: date)
      self.hour = hour
      self.UVI = UVI
      self.heatIndex = heatIndex
      self.windChill = windChill
   }
}
