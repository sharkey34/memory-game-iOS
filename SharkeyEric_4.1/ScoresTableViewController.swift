//
//  ScoresTableViewController.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 8/20/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import CoreData

class ScoresTableViewController: UITableViewController {
    
    // Variables
    var managedContext: NSManagedObjectContext!
    var leaderBoardData: NSManagedObject!
    private var dataObj: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting color, showing the navigation bar, and calling the load function.
        tableView.backgroundColor = UIColor.init(red:0.80, green:0.25, blue:0.25, alpha:1.0)
        navigationController?.isNavigationBarHidden = false
        load()
        
        // If the data object is nil the displaying an alert and popping view controller.
        if dataObj.count == 0{
            let alert = UIAlertController.init(title: "Sorry!", message: "No scores have been saved to display.", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "OK", style: .default) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Setting row and section header height and separator color.
        tableView.rowHeight = 106
        tableView.sectionHeaderHeight = 65
        tableView.separatorColor = UIColor.init(displayP3Red: 0.63, green:0.86, blue:1.00, alpha:1.0)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LeaderBoard: Top 10"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataObj.count > 10{
            return 10
        } else {
            return dataObj.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Setting the cell as a reusable ScoresTableViewCell.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as? ScoresTableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)}
        
        // Cetting the name labels values and getting the other valuse from the dataobj
        cell.nameLabel.text = dataObj[indexPath.row].value(forKey: "userName") as? String
        let moves = dataObj[indexPath.row].value(forKey: "moves") as? Int
        let date = dataObj[indexPath.row].value(forKey: "date") as? Date
        let time = dataObj[indexPath.row].value(forKey: "time") as? Int
        
        // formatting and setting the time label.
        if let t = time {
            let timeMinutes = t / 60 % 60
            let timeSeconds = t % 60
            cell.timeLabel.text = String(format:"%02i:%02i", timeMinutes, timeSeconds)
        } else {
            cell.timeLabel.text = "N/A"
        }
        
        // Formatting and setting the date label.
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        if let d = date{
            let dateString = formatter.string(from: d)
            cell.dateLabel.text = dateString
            
        }
        
        // Setting position and moves and background color.
        let position = indexPath.row + 1
        cell.positionLabel.text = "\(position)."
        
        cell.backgroundColor = UIColor.init(red:1.00, green:1.00, blue:0.92, alpha:1.0)
        cell.movesLabel.text = moves?.description
        return cell
    }
    
    // Load function sorting the data and loading the sorted data into the dataObj.
    func load(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeaderBoardData")
        let sorty = NSSortDescriptor(key: "time", ascending: true)
        fetchRequest.sortDescriptors = [sorty]
        do{
            let data: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            
            for obj in data {
                dataObj.append(obj)
            }
            
        } catch {
            assertionFailure()
        }
    }
    
    // TODO: Implement a reset button to delete the leaderboard data.
    func reset(){
          managedContext.delete(leaderBoardData)
    }
    
    // Displaying the navigation bar when the view has disappeared.
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
