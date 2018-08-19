//
//  ContactViewModel.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 10/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//

import Foundation

struct ContactViewModel {
    
    let first_name: String
    
    init(contact: ContactStruct) {
        self.first_name = contact.first_name
    }
    
    
}
