//
//  ContactUITableViewCell.swift
//  Friends
//
//  Created by s5014219 on 13/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class ContactUITableViewCell: UITableViewCell {

    @IBOutlet weak var imageDisplay: UIImageView!

    @IBOutlet weak var fullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
