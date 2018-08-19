//
//  Contact+CoreDataProperties.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 10/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var profile_pic: String?
    @NSManaged public var last_name: String?
    @NSManaged public var first_name: String

}
