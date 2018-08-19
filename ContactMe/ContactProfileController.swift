//
//  ContactProfileController.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 17/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactProfileController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contanctDetailCell", for: indexPath) as! ContactInfoCell
        let cellData = detailArray[indexPath.row]
        cell.titleLabel.text = cellData["Title"]
        cell.dataLabel.text = cellData["Data"]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellId = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactActionCell", for: indexPath) as! ContactActionCollectionViewCell
        let action = actionArray[indexPath.row]
        collectionCellId.actionTitle.text = action
        collectionCellId.actionIcon.image = UIImage(named: action)
        return collectionCellId
    }
    
    
    
    let actionArray = ["Message","Call","Email","Favourite"]
    let detailArray = [["Title":"Mobile","Data":"9999"],["Title":"Email","Data":"a@gmail.com"]]

    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    

    
}


