//
//  FlowerTableViewCell.swift
//  FlowerServerApp
//
//  Created by Mostafa AbdEl Fatah on 11/23/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class FlowerTableViewCell: UITableViewCell {

    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var flowerNameLabel: UILabel!
    @IBOutlet weak var flowerCategoryLabel: UILabel!
    @IBOutlet weak var flowerPriceLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.contentView.layer.borderWidth = 5.0
    }
    
}
