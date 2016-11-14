//
//  RestaurantViewCell.swift
//  FoodPin
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class RestaurantViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
