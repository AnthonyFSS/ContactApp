//
//  ContactInfoCell.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 18/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dataLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
