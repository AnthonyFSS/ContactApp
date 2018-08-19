//
//  ContactCellTableViewCell.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 09/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
//    var link: HomeTableViewController?
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        let startBUtton = UIButton(type: .system)
//        startBUtton.setImage(#imageLiteral(resourceName: "star-outline03"), for: .normal)
//        startBUtton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        startBUtton.tintColor = .lightGray
//        startBUtton.addTarget(self, action: #selector(addAsFavourite), for:.touchUpInside)
//
//        accessoryView = startBUtton
//
//    }
//
//    @objc func addAsFavourite(){
//        print("Added as favourite")
//        link?.someMethod(cell: self)
//    }
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    static let reuseIdentifier = "ContactCell"

    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
