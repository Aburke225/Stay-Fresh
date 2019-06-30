//
//  FoodTableViewController.swift
//  ShelfLife
//
//  Created by Andrew Burke on 6/19/19.
//  Copyright © 2019 Andrew Burke. All rights reserved.
//

import UIKit
import os.log

class FoodTableViewController: UITableViewController {
    
    
    var timer = Timer()
    
    //MARK: Properties
    
    var foods = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        let savedMeals = loadMeals()
        
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: (#selector(FoodTableViewController.updateTimer)), userInfo: nil, repeats: true)
        
        if savedMeals?.count ?? 0 > 0 {
            foods = savedMeals ?? [Meal]()
        }
//        else {
//            loadSampleMeals()
//        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FoodTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FoodTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let food = foods[indexPath.row]
        
        cell.nameLabel.text = food.name
        cell.photoImageView.image = food.photo
        
        if food.timeLabel >= 0 {
            cell.timeLabel.text = String(food.timeLabel) + " days left"
        } else {
            cell.timeLabel.text = "Expired"
            cell.timeLabel.textColor = UIColor.red
            cell.nameLabel.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    @objc func updateTimer() {
        let date = Date() // now
        let cal = Calendar.current
        let today = cal.ordinality(of: .day, in: .year, for: date)
        
        for food in foods {
            var difference = today! - food.todayDay
            
            if difference < 0 {
                difference += 365
                food.timeLabel -= difference
                food.todayDay += (difference - 365)
            } else {
                food.timeLabel -= difference
                food.todayDay += difference
            }
        }
        saveFoods()
        tableView.reloadData()
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            foods.remove(at: indexPath.row)
            saveFoods()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new food.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? FoodViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? FoodTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = foods[indexPath.row]
            mealDetailViewController.food = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? FoodViewController, let food = sourceViewController.food {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal.
                foods[selectedIndexPath.row] = food
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                
                // Add a new food.
                let newIndexPath = IndexPath(row: foods.count, section: 0)
            
                foods.append(food)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the foods.
            saveFoods()
            
        }
    }

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func saveFoods() {
        let fullPath = getDocumentsDirectory().appendingPathComponent("foods")
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: foods, requiringSecureCoding: false)
            try data.write(to: fullPath)
            os_log("Foods successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save foods...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Meal]? {
        let fullPath = getDocumentsDirectory().appendingPathComponent("foods")
        
        if let nsData = NSData(contentsOf: fullPath) {
            do {
                
                let data = Data(referencing:nsData)
                
                if let loadedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Meal> {
                    return loadedMeals
                }
            } catch {
                print("Couldn't read file.")
                return nil
            }
        }
        return nil
    }

}
