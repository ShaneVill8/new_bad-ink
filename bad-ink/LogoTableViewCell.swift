//
//  LogoTableViewCell.swift
//  bad-ink
//
//  Created by User on 3/5/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit

class LogoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
