//
//  FoodViewController.swift
//  ShelfLife
//
//  Created by Andrew Burke on 6/11/19.
//  Copyright © 2019 Andrew Burke. All rights reserved.
//

import UIKit
import os.log

class FoodViewController: UIViewController, UITextFieldDelegate,
        UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var boolean = true
    var foodResult = ""
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet var selectButton: [UIButton]!
    @IBOutlet weak var fridgeButton: UIButton!
    @IBOutlet weak var freezerButton: UIButton!
    
    @IBOutlet weak var BS: UIButton!
    @IBOutlet weak var BVLP: UIButton!
    @IBOutlet weak var CC: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var E: UIButton!
    @IBOutlet weak var FF: UIButton!
    @IBOutlet weak var GM: UIButton!
    @IBOutlet weak var H: UIButton!
    @IBOutlet weak var HD: UIButton!
    @IBOutlet weak var L: UIButton!
    @IBOutlet weak var P: UIButton!
    @IBOutlet weak var S: UIButton!
    @IBOutlet weak var SF: UIButton!
    @IBOutlet weak var SS: UIButton!
    
    @IBAction func fridge(_ sender: AnyObject) {
        boolean = true
        
        freezerButton.setTitleColor(UIColor (
            red: 0,
            green: 122/255,
            blue: 255/255,
            alpha: 1.0), for: .normal)
        freezerButton.backgroundColor = UIColor.white
        
        fridgeButton.setTitleColor(.white, for: .normal)
        fridgeButton.backgroundColor = UIColor (
            red: 0,
            green: 122/255,
            blue: 255/255,
            alpha: 1.0)
    }
    
    @IBAction func freezer(_ sender: AnyObject) {
        boolean = false
        
        fridgeButton.setTitleColor(UIColor (
            red: 0,
            green: 122/255,
            blue: 255/255,
            alpha: 1.0), for: .normal)
        fridgeButton.backgroundColor = UIColor.white
        
        freezerButton.setTitleColor(.white, for: .normal)
        freezerButton.backgroundColor = UIColor (
            red: 0,
            green: 122/255,
            blue: 255/255,
            alpha: 1.0)
    }
    
    /*
     This value is either passed by `FoodTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new food.
     */
    var food: Meal?
    var days = 0.0
    
    @IBOutlet var foodTypes: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAllButtons()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
//        // Set up views if editing an existing Meal.
//        if let meal = food {
//            foodResult = meal.foodGroup
//            nameTextField.text = meal.name
//            photoImageView.image = meal.photo
//        }
        
        // Enable the Done button only if the text field has a valid Meal name.
        updateDoneButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateDoneButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Done button while editing.
        doneButton.isEnabled = false
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
//        guard let selectedImage = info[.originalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
        
        // Set photoImageView to display the selected image.
//        photoImageView.image = UIImage(named: buttonResult.text!)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === doneButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = UIImage(named: foodResult)
        let foodGroup = foodResult
        
        if boolean {
            if foodGroup == "Bacon and Sausage" {
                days = 7
            } else if foodGroup == "Beef, Veal, Lamb, and Pork" {
                days = 5
            } else if foodGroup == "Cold Cuts" {
                days = 5
            } else if foodGroup == "Dairy" {
                days = 14
            } else if foodGroup == "Eggs" {
                days = 21
            } else if foodGroup == "Fruits and Vegetables" {
                days = 7
            } else if foodGroup == "Ground Meat" {
                days = 2
            } else if foodGroup == "Ham" {
                days = 5
            } else if foodGroup == "Hot Dogs" {
                days = 7
            } else if foodGroup == "Leftovers" {
                days = 3
            } else if foodGroup == "Poultry" {
                days = 2
            } else if foodGroup == "Salad" {
                days = 4
            } else if foodGroup == "Seafood" {
                days = 2
            } else {
                days = 4
            }
        } else {
            if foodGroup == "Bacon and Sausage" {
                days = 30
            } else if foodGroup == "Beef, Veal, Lamb, and Pork" {
                days = 120
            } else if foodGroup == "Cold Cuts" {
                days = 60
            } else if foodGroup == "Dairy" {
                days = 180
            } else if foodGroup == "Eggs" {
                days = 0
            } else if foodGroup == "Fruits and Vegetables" {
                days = 240
            } else if foodGroup == "Ground Meat" {
                days = 120
            } else if foodGroup == "Ham" {
                days = 60
            } else if foodGroup == "Hot Dogs" {
                days = 60
            } else if foodGroup == "Leftovers" {
                days = 30
            } else if foodGroup == "Poultry" {
                days = 270
            } else if foodGroup == "Salad" {
                days = 0
            } else if foodGroup == "Seafood" {
                days = 90
            } else {
                days = 60
            }
        }
        
        let date = Date() // now
        let cal = Calendar.current
        let todayDay = cal.ordinality(of: .day, in: .year, for: date)
        
        let timeLabel = Int(days)
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        food = Meal(name: name, photo: photo, foodGroup: foodGroup, timeLabel: timeLabel, todayDay: todayDay!)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that
        // lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func handleSelection(_ sender: UIButton) {
        foodTypes.forEach { (button) in
            button.isHidden = !button.isHidden
        }
        setAllButtons()
    }
    
    enum Foods: String {
        case BS = "Bacon and Sausage"
        case BVLP = "Beef, Veal, Lamb, and Pork"
        case CC = "Cold Cuts"
        case D = "Dairy"
        case E = "Eggs"
        case FF = "Fruits and Vegetables"
        case GM = "Ground Meat"
        case H = "Ham"
        case HD = "Hot Dogs"
        case L = "Leftovers"
        case P = "Poultry"
        case S = "Salad"
        case SF = "Seafood"
        case SS = "Soups and Stews"
    }
    
    @IBAction func foodTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let food = Foods(rawValue: title) else {
            return
        }
        
        switch food {
        case .BS:
            foodResult = "Bacon and Sausage"
            setAllButtons()
            BS.setTitleColor(.white, for: .normal)
            BS.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .BVLP:
            foodResult = "Beef, Veal, Lamb, and Pork"
            setAllButtons()
            BVLP.setTitleColor(.white, for: .normal)
            BVLP.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .CC:
            foodResult = "Cold Cuts"
            setAllButtons()
            CC.setTitleColor(.white, for: .normal)
            CC.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .D:
            foodResult = "Dairy"
            setAllButtons()
            D.setTitleColor(.white, for: .normal)
            D.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .E:
            foodResult = "Eggs"
            setAllButtons()
            E.setTitleColor(.white, for: .normal)
            E.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .FF:
            foodResult = "Fruits and Vegetables"
            setAllButtons()
            FF.setTitleColor(.white, for: .normal)
            FF.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .GM:
            foodResult = "Ground Meat"
            setAllButtons()
            GM.setTitleColor(.white, for: .normal)
            GM.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .H:
            foodResult = "Ham"
            setAllButtons()
            H.setTitleColor(.white, for: .normal)
            H.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .HD:
            foodResult = "Hot Dogs"
            setAllButtons()
            HD.setTitleColor(.white, for: .normal)
            HD.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .L:
            foodResult = "Leftovers"
            setAllButtons()
            L.setTitleColor(.white, for: .normal)
            L.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .P:
            foodResult = "Poultry"
            setAllButtons()
            P.setTitleColor(.white, for: .normal)
            P.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .S:
            foodResult = "Salad"
            setAllButtons()
            S.setTitleColor(.white, for: .normal)
            S.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        case .SF:
            foodResult = "Seafood"
            setAllButtons()
            SF.setTitleColor(.white, for: .normal)
            SF.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        default:
            foodResult = "Soups and Stews"
            setAllButtons()
            SS.setTitleColor(.white, for: .normal)
            SS.backgroundColor = UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0)
        }
        
        updateDoneButtonState()
    }
    
    
    //MARK: Private Methods
    
    private func updateDoneButtonState() {
        // Disable the Done button if the text field is empty.
        let text = nameTextField.text ?? ""
        let bR = foodResult
        doneButton.isEnabled = !text.isEmpty && !bR.isEmpty
    }
    
    private func setAllButtons() {
        let buttonArray = [BS, BVLP, CC, D, E, FF, GM, H, HD, L, P, S, SF, SS]
        for button in buttonArray {
            button!.setTitleColor(UIColor (
                red: 0,
                green: 122/255,
                blue: 255/255,
                alpha: 1.0), for: .normal)
            button!.backgroundColor = UIColor.white
            button!.layer.borderWidth = 1
            button!.layer.borderColor = (UIColor( red: 0, green: 122/255, blue: 1, alpha: 1.0 )).cgColor
        }
    }
    
}

