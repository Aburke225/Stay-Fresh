//
//  FoodTableViewController.swift
//  ShelfLife
//
//  Created by Andrew Burke on 6/19/19.
//  Copyright © 2019 Andrew Burke. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var foods = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleMeals()
        
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
        cell.ratingControl.rating = food.rating
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        let photoBS = UIImage(named: "Bacon and Sausage")
        let photoBVLP = UIImage(named: "Beef, Veal, Lamb, and Pork")
        let photoCC = UIImage(named: "Cold Cuts")
        let photoE = UIImage(named: "Eggs")
        let photoGM = UIImage(named: "Ground Meat")
        let photoH = UIImage(named: "Ham")
        let photoHD = UIImage(named: "Hot Dogs")
        let photoL = UIImage(named: "Leftovers")
        let photoP = UIImage(named: "Poultry")
        let photoS = UIImage(named: "Salad")
        let photoSS = UIImage(named: "Soups and Stews")
        
        guard let BS = Meal(name: "Bacon and Sausage", photo: photoBS, rating: 4) else {
            fatalError("Unable to instantiate mealBS")
        }
        
        guard let BVLP = Meal(name: "Beef, Veal, Lamb, and Pork", photo: photoBVLP, rating: 5) else {
            fatalError("Unable to instantiate mealBVLP")
        }
        
        guard let CC = Meal(name: "Cold Cuts", photo: photoCC, rating: 3) else {
            fatalError("Unable to instantiate mealCC")
        }
        
        guard let E = Meal(name: "Eggs", photo: photoE, rating: 4) else {
            fatalError("Unable to instantiate mealE")
        }
        
        guard let GM = Meal(name: "Ground Meat", photo: photoGM, rating: 5) else {
            fatalError("Unable to instantiate mealGM")
        }
        
        guard let H = Meal(name: "Ham", photo: photoH, rating: 3) else {
            fatalError("Unable to instantiate mealH")
        }
        
        guard let HD = Meal(name: "Hot Dogs", photo: photoHD, rating: 4) else {
            fatalError("Unable to instantiate mealHD")
        }
        
        guard let L = Meal(name: "Leftovers", photo: photoL, rating: 5) else {
            fatalError("Unable to instantiate mealL")
        }
        
        guard let P = Meal(name: "Poultry", photo: photoP, rating: 3) else {
            fatalError("Unable to instantiate mealP")
        }
        
        guard let S = Meal(name: "Salad", photo: photoS, rating: 4) else {
            fatalError("Unable to instantiate mealS")
        }
        
        guard let SS = Meal(name: "Soups and Stews", photo: photoSS, rating: 5) else {
            fatalError("Unable to instantiate mealSS")
        }
        
        foods += [BS, BVLP, CC, E, GM, H, HD, L, P, S, SS]
        
    }

}
