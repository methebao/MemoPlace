//
//  DetailViewCellTableViewCell.swift
//  FoodPin
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
