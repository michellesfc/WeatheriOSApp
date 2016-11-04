//
//  WeatherFields.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/28/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import Foundation
import UIKit

class WeatherBuilder {
   
   let apiCurrentDay = "http://api.wunderground.com/api/6c0006a0992b8fc9/conditions/q/CA/San_Francisco.json"
   let apiForecast10day = "http://api.wunderground.com/api/6c0006a0992b8fc9/forecast10day/q/CA/San_Francisco.json"
   let apiHourly10day = "http://api.wunderground.com/api/6c0006a0992b8fc9/hourly10day/q/CA/San_Francisco.json"
   
   func getJsonResponse(url:String) -> [String:Any]? {
      
      let data = try! Data(contentsOf: NSURL(string: url)! as URL)
      
      var jsonResponse : [String:AnyObject]?
      
      do {
         jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
      }
      catch {
         print("Caught exception")
      }

      return jsonResponse
   }
   
   
   func createCurrentDay(currentForecast: [String:Any]?) -> WeatherDay {
      let currentDayJSON = getJsonResponse(url: apiCurrentDay);
      
      let currentObservation = currentDayJSON!["current_observation"] as! [String : Any]
      let displayLocation = currentObservation["display_location"] as! [String : Any]
      
      
      let date = currentObservation["observation_time_rfc822"] as! String?
      let city = displayLocation["city"] as! String?
      let conditions = currentObservation["weather"] as! String?
      let temperature = currentObservation["temp_f"] as! Int?
      let currentWindSpd = currentObservation["wind_mph"] as! Int?
      let currentWindDir = currentObservation["wind_dir"] as! String?
      let conditionImg = currentObservation["icon_url"] as! String?
      
      let dayOfWeek = (currentForecast?["date"] as! [String: Any])["weekday"] as! String?
      let highTemp = (currentForecast?["high"] as! [String:Any])["fahrenheit"] as! String?
      let lowTemp = (currentForecast?["low"] as! [String:Any])["fahrenheit"] as! String?
      let probOfPrecip = currentForecast?["pop"] as! Int?
      let hours = [WeatherHour]()
      
      return WeatherDay(city: city, conditions: conditions, conditionImg: conditionImg, temperature: temperature, dayOfWeek: dayOfWeek, windSpeed: currentWindSpd, windDirection: currentWindDir, probOfPrecip: probOfPrecip, date: date, highTemp: highTemp, lowTemp: lowTemp, hours: hours)

   }
   
   func createWeatherDay(dayJSON: [String:Any]?) -> WeatherDay {
      let conditions = dayJSON?["conditions"] as! String?
      let conditionImg = dayJSON?["icon_url"] as! String?
      let dayOfWeek = (dayJSON?["date"] as! [String: Any])["weekday"] as! String?
      let highTemp = (dayJSON?["high"] as! [String:Any])["fahrenheit"] as! String?
      let lowTemp = (dayJSON?["low"] as! [String:Any])["fahrenheit"] as! String?
      let probOfPrecip = dayJSON?["pop"] as! Int?
      let hours = [WeatherHour]()
      let aveWind = (dayJSON?["avewind"] as! [String: Any])
      let windSpeed = aveWind["mph"] as! Int?
      let windDirection = aveWind["dir"] as! String?

      return WeatherDay(city: nil, conditions: conditions, conditionImg: conditionImg, temperature: nil, dayOfWeek: dayOfWeek, windSpeed: windSpeed, windDirection: windDirection, probOfPrecip: probOfPrecip,  date: nil, highTemp: highTemp, lowTemp: lowTemp, hours: hours)
   }
   
   
   func createWeatherHour(hourJSON: [String:Any]?) -> WeatherHour {
      let conditions = hourJSON?["conditions"] as! String?
      let conditionImg = hourJSON?["icon_url"] as! String?
      let timeDescription = hourJSON?["FCTTIME"] as! [String: Any]
      let dayOfWeek = timeDescription["weekday_name"] as! String?
      let temperature = Int((hourJSON?["temp"] as! [String: String])["english"]!)
      let date = timeDescription["pretty"] as! String?
      let hour = Int(timeDescription["hour"] as! String)
      let UVI = Int(hourJSON?["uvi"] as! String)
      let heatIndex = Int((hourJSON?["heatindex"] as! [String: String])["english"]!)
      let windSpeed = Int((hourJSON?["wspd"] as! [String: String])["english"]!)
      let windDirection = (hourJSON?["wdir"] as! [String: Any])["dir"] as! String?
      let windChill = Int((hourJSON?["windchill"] as! [String: String])["english"]!)
      let probOfPrecip = Int(hourJSON?["pop"] as! String)
      //print(hour!)
      return WeatherHour(city: nil, conditions: conditions, conditionImg: conditionImg, temperature: temperature, dayOfWeek: dayOfWeek, windSpeed: windSpeed, windDirection: windDirection, probOfPrecip: probOfPrecip,  date: date, hour: hour, UVI: UVI, heatIndex: heatIndex, windChill: windChill)
   }
 
   func createWeatherObjects() -> [WeatherDay] {
      var result:[WeatherDay] = [WeatherDay]()
      
      
      let forecast10dayJSON = getJsonResponse(url: apiForecast10day);
      
      let forecast = (forecast10dayJSON!["forecast"] as! [String:Any])["simpleforecast"] as! [String:Any]
      let day = forecast["forecastday"] as! [[String:Any]]
      
      let hourlyForecast = getJsonResponse(url: apiHourly10day)?["hourly_forecast"] as! [[String: Any]]
      
      result.append(createCurrentDay(currentForecast: day[0]))
   
      for index in 1...9 {
         result.append(createWeatherDay(dayJSON: day[index]))
      }
      
      
      var firstH = 24 - Int((hourlyForecast[0]["FCTTIME"] as! [String: Any])["hour"] as! String)!
      
      for hour in 0...firstH-1 {
         (result[0].hours!).append(createWeatherHour(hourJSON: hourlyForecast[hour]))
      }
      
      var c = 0;
      for dayIdx in 1...9 {
         c = 0
         while(c < 24) {
            (result[dayIdx].hours)!.append(createWeatherHour(hourJSON: hourlyForecast[firstH]))
            firstH += 1
            c += 1
         }
         
      }
      
      /*
       
      var hoursIdx = hourlyForecast.count - 1
      var dayIdx = 9;
       
      var h = 23
      while(hoursIdx >= 0 && dayIdx >= 0) {
         //((result[dayIdx].hours))!.insert(createWeatherHour(hourJSON: hourlyForecast[hoursIdx]), at: h)
         print("test: \(h) \(hoursIdx) \(dayIdx)")
         h -= 1
         hoursIdx -= 1
         if(h == 0) {
            dayIdx -= 1
            h = 23
         }
      }*/
      return result
   }
   
   

}
