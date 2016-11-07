//
//  ViewController.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 10/27/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//
//

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
      
      let currentWeather:WeatherDay = weatherObjects[0]
      
      //Setting the texts for the labels
      cityLabel.text = currentWeather.city
      weekDayLabel.text = currentWeather.dayOfWeek
      tempLabel.text = String(describing: currentWeather.temperature!) + "°F"
      conditionLabel.text = currentWeather.conditions
      highLowTempLabel.text = "\u{f055}   " + currentWeather.highTemp! + "°F / " + currentWeather.lowTemp! + "°F"
      windLabel.text = "\u{f050} " + String(describing: currentWeather.windSpeed!) + " mph / " + currentWeather.windDirection!
      weatherIcon.text = currentWeather.conditionImg
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let builder:WeatherBuilder = WeatherBuilder();
      weatherObjects = builder.createWeatherObjects();
      
      setCurrentDayLabels()
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
      cell.iconLabel.text = weatherDay.conditionImg!
      cell.popLabel.text = "\u{f078} " + String(describing: weatherDay.probOfPrecip!) + "%"
      cell.highLabel.text = "\u{f058} " + weatherDay.highTemp! + "°F"
      cell.lowLabel.text = "\u{f044} " + weatherDay.lowTemp! + "°F"
      cell.conditionLabel.text = weatherDay.conditions!
      return cell
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if(segue.identifier == "DayToHourView") {
         let destVC = segue.destination as! HoursViewController
         
         let selectedIndexPath = day10Forecast.indexPathsForSelectedItems![0].item
         
         //pass the hours array for the selected day to the destination view controller
         destVC.hours = weatherObjects[selectedIndexPath].hours!
      }
   }

   
   @IBAction func backToMainUnwind(segue:UIStoryboardSegue) {
   }

}

