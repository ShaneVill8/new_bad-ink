//
//  ProductTableViewCell.swift
//  bad-ink
//
//  Created by David Twyman on 3/16/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var picture: UIImageView!
    @IBOutlet var price: UILabel!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
