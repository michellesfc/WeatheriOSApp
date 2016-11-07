//
//  HoursViewController.swift
//  WeatheriOSApp
//
//  Created by Michelle Gu on 11/3/16.
//  Copyright © 2016 Michelle Gu. All rights reserved.
//

import UIKit

class HoursViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var hoursTableView: UITableView!
   @IBOutlet weak var navigationBar: UINavigationItem!
   
   var hours:[WeatherHour] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return hours.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "customHourCell", for: indexPath) as? HourTableViewCell
      
      let h = hours[indexPath.row]
      cell?.popLabel.text = "\u{f078} " + String(h.probOfPrecip!) + "%"
      cell?.hourLabel.text = String(h.hour!)
      cell?.tempLabel.text = "\u{f055} " + String(h.temperature!) + "°F"
      cell?.windLabel.text = "\u{f050} " + String(h.windSpeed!) + " mph"
      
      let date = h.date!
      let idx = date.range(of: "on")?.upperBound
      navigationBar.title = h.dayOfWeek! + ", " + h.date!.substring(from: idx!)

      return cell!
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if(segue.identifier == "hourToDetail") {
         let destVC = segue.destination as! HourDetailViewController
         let selectedIndexPath = hoursTableView.indexPathForSelectedRow?.row
         //pass the selected weather hour object to the destination view controller
         destVC.hour = hours[selectedIndexPath!]
      }
   }
   
   @IBAction func backToHoursUnwind(segue:UIStoryboardSegue) {
   }

}
