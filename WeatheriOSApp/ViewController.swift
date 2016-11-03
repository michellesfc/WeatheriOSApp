//
//  ViewController.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/27/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//
//6c0006a0992b8fc9

import UIKit

class ViewController: UIViewController {
   @IBOutlet weak var cityLabel: UILabel!
   @IBOutlet weak var weekDayLabel: UILabel!
   @IBOutlet weak var tempLabel: UILabel!
   @IBOutlet weak var conditionLabel: UILabel!
   @IBOutlet weak var weatherIcon: UILabel!
   @IBOutlet weak var highLowTempLabel: UILabel!
   @IBOutlet weak var windLabel: UILabel!
   
   func setCurrentDayLabels() {
      let test:WeatherBuilder = WeatherBuilder();
      let WeatherObjects:[WeatherDay] = test.createWeatherObjects();
      let currentWeather:WeatherDay = WeatherObjects[0]
      cityLabel.text = currentWeather.city
      weekDayLabel.text = currentWeather.dayOfWeek
      tempLabel.text = String(describing: currentWeather.temperature!) + "°F"
      conditionLabel.text = currentWeather.conditions
      
      weatherIcon.font = UIFont(name: "WeatherIcons-Regular", size: 150)
      
      highLowTempLabel.text = "\u{f055}  " + currentWeather.highTemp! + "°F / " + currentWeather.lowTemp! + "°F"
      
      windLabel.text = "\u{f050} " + String(describing: currentWeather.windSpeed!) + " mph / " + currentWeather.windDirection!
    
      weatherIcon.text = " \u{F002}"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setCurrentDayLabels()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

}

