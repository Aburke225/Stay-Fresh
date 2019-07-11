//
//  FoodTableViewCell.swift
//  ShelfLife
//
//  Created by Andrew Burke on 6/19/19.
//  Copyright © 2019 Andrew Burke. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
