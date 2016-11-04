//
//  ViewController.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/27/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//
//6c0006a0992b8fc9

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   @IBOutlet weak var cityLabel: UILabel!
   @IBOutlet weak var weekDayLabel: UILabel!
   @IBOutlet weak var tempLabel: UILabel!
   @IBOutlet weak var conditionLabel: UILabel!
   @IBOutlet weak var weatherIcon: UILabel!
   @IBOutlet weak var highLowTempLabel: UILabel!
   @IBOutlet weak var windLabel: UILabel!
   
   @IBOutlet weak var day10Forecast: UICollectionView!
   
   var weatherObjects:[WeatherDay] = []
   
   func setCurrentDayLabels() {
      let test:WeatherBuilder = WeatherBuilder();
      weatherObjects = test.createWeatherObjects();
      let currentWeather:WeatherDay = weatherObjects[0]
      cityLabel.text = currentWeather.city
      weekDayLabel.text = currentWeather.dayOfWeek
      tempLabel.text = String(describing: currentWeather.temperature!) + "°F"
      conditionLabel.text = currentWeather.conditions
      
      highLowTempLabel.text = "\u{f055}   " + currentWeather.highTemp! + "°F / " + currentWeather.lowTemp! + "°F"
      
      windLabel.text = "\u{f050} " + String(describing: currentWeather.windSpeed!) + " mph / " + currentWeather.windDirection!
    
      weatherIcon.text = " \u{F002}"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setCurrentDayLabels()
      print("in main view")
      /*
      for w in weatherObjects {
         for h in w.hours! {
            print(h.hour!)
         }
         print("\n\n\n")
      }*/
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 10
   }

   func collectionView(_ collectionView: UICollectionView,
                                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
      let weatherDay = weatherObjects[indexPath.row]
      cell.weekdayLabel.text = weatherDay.dayOfWeek
      cell.iconLabel.text = "\u{F002}"
      cell.popLabel.text = "\u{f078} " + String(describing: weatherDay.probOfPrecip!) + "%"
      cell.highLabel.text = "\u{f058} " + weatherDay.highTemp! + "°F"
      cell.lowLabel.text = "\u{f044} " + weatherDay.lowTemp! + "°F"
      return cell
   }
   
   @IBAction func backToMainUnwind(segue:UIStoryboardSegue) {
      
   }

}

