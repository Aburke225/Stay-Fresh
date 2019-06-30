//
//  Food.swift
//  ShelfLife
//
//  Created by Andrew Burke on 6/13/19.
//  Copyright © 2019 Andrew Burke. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var foodGroup: String
    var timeLabel: Int
    var todayDay: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("foods")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let foodGroup = "foodGroup"
        static let timeLabel = "timeLabel"
        static let todayDay = "todayDay"
    }
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, foodGroup: String, timeLabel: Int, todayDay: Int) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The foodGroup must not be empty
        guard !foodGroup.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = 3
        self.foodGroup = foodGroup
        self.timeLabel = timeLabel
        self.todayDay = todayDay
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(foodGroup, forKey: PropertyKey.foodGroup)
        aCoder.encode(timeLabel, forKey: PropertyKey.timeLabel)
        aCoder.encode(todayDay, forKey: PropertyKey.todayDay)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
//        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        guard let foodGroup = aDecoder.decodeObject(forKey: PropertyKey.foodGroup) as? String else { return nil }
        
        let timeLabel = aDecoder.decodeInteger(forKey: PropertyKey.timeLabel)
        
        let todayDay = aDecoder.decodeInteger(forKey: PropertyKey.todayDay)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, foodGroup: foodGroup, timeLabel: timeLabel, todayDay: todayDay)
    }
    
}
