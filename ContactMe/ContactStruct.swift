//
//  Contact.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 10/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//

import Foundation

struct ContactStruct: Decodable{
    let id: Int
    let first_name: String
    let last_name: String
    let profile_pic: String
    let favorite: Bool
    let url: String

}
