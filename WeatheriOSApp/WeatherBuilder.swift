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
      
      var jsonResponse : [String:Any]?
      
      do {
         jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
      }
      catch {
         print("Caught exception")
      }

      return jsonResponse
   }
   
   func getWeatherIcon(condition: String) -> String {
      var res: String = ""
      switch condition {
         case "Clear", "Sunny", "Partly Sunny", "Mostly Sunny":
            res = "\u{f00d}"
         case "Cloudy", "Mostly Cloudy", "Partly Cloudy", "Overcast":
            res = "\u{f013}"
         case "Flurries", "Snow":
            res = "\u{f01b}"
         case "Freezing Rain", "Sleet":
            res = "\u{f0b5}"
         case "Thunderstorms", "Thunderstorm":
            res = "\u{f01e}"
         case "Scattered Clouds":
            res = "\u{f002}"
         case "Fog":
            res = "\u{f014}"
         case "Haze":
            res = "\u{f0b6}"
         case "Rain":
            res = "\u{f019}"
         default:
            res = "\u{f075}"
      }
      return res
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
      let conditionImg = getWeatherIcon(condition: conditions!)
      
      let dayOfWeek = (currentForecast?["date"] as! [String: Any])["weekday"] as! String?
      let highTemp = (currentForecast?["high"] as! [String:Any])["fahrenheit"] as! String?
      let lowTemp = (currentForecast?["low"] as! [String:Any])["fahrenheit"] as! String?
      let probOfPrecip = currentForecast?["pop"] as! Int?
      let hours = [WeatherHour]()
      
      return WeatherDay(city: city, conditions: conditions, conditionImg: conditionImg, temperature: temperature, dayOfWeek: dayOfWeek, windSpeed: currentWindSpd, windDirection: currentWindDir, probOfPrecip: probOfPrecip, date: date, highTemp: highTemp, lowTemp: lowTemp, hours: hours)

   }
   
   func createWeatherDay(dayJSON: [String:Any]?) -> WeatherDay {
      let conditions = dayJSON?["conditions"] as! String?
      let conditionImg = getWeatherIcon(condition: conditions!)
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
      let timeDescription = hourJSON?["FCTTIME"] as! [String: Any]
      let dayOfWeek = timeDescription["weekday_name"] as! String?
      let date = timeDescription["pretty"] as! String?
      let hour = timeDescription["civil"] as! String?
      
      let temperature = Int((hourJSON?["temp"] as! [String: String])["english"]!)
      let conditions = hourJSON?["condition"] as! String?
      let conditionImg = getWeatherIcon(condition: conditions!)
      let probOfPrecip = Int(hourJSON?["pop"] as! String)
      let UVI = Int(hourJSON?["uvi"] as! String)
      let heatIndex = Int((hourJSON?["heatindex"] as! [String: String])["english"]!)
      let windSpeed = Int((hourJSON?["wspd"] as! [String: String])["english"]!)
      let windDirection = (hourJSON?["wdir"] as! [String: Any])["dir"] as! String?
      let windChill = Int((hourJSON?["windchill"] as! [String: String])["english"]!)
      
      return WeatherHour(city: nil, conditions: conditions, conditionImg: conditionImg, temperature: temperature, dayOfWeek: dayOfWeek, windSpeed: windSpeed, windDirection: windDirection, probOfPrecip: probOfPrecip,  date: date, hour: hour, UVI: UVI, heatIndex: heatIndex, windChill: windChill)
   }
 
   func createWeatherObjects() -> [WeatherDay] {
      var result:[WeatherDay] = [WeatherDay]()
      
      let forecast10dayJSON = getJsonResponse(url: apiForecast10day);
      let forecast = (forecast10dayJSON!["forecast"] as! [String:Any])["simpleforecast"] as! [String:Any]
      let day = forecast["forecastday"] as! [[String:Any]]
      
      let hourlyForecast = getJsonResponse(url: apiHourly10day)?["hourly_forecast"] as! [[String: Any]]
      
      //create current weather day object
      result.append(createCurrentDay(currentForecast: day[0]))
      
      //create the weather objects for the other 9 days
      for index in 1...9 {
         result.append(createWeatherDay(dayJSON: day[index]))
      }
      
      
      var hoursIdx = 24 - Int((hourlyForecast[0]["FCTTIME"] as! [String: Any])["hour"] as! String)!
      
      //create the weather hour objects for the current day (first weather day objects)
      for h in 0...hoursIdx-1 {
         (result[0].hours!).append(createWeatherHour(hourJSON: hourlyForecast[h]))
      }
      
      //create the weather hour objects for the other 9 days
      var counter = 0;
      for dayIdx in 1...9 {
         counter = 0
         while(counter < 24) {
            if(counter == Int((hourlyForecast[hoursIdx]["FCTTIME"] as! [String: Any])["hour"] as! String)!) {
               (result[dayIdx].hours)!.append(createWeatherHour(hourJSON: hourlyForecast[hoursIdx]))
               counter += 1
            }
            hoursIdx += 1
         }
         
      }
      
      return result
   }
   
   

}
