//
//  Service.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 10/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//


import Foundation
import UIKit
import CoreData

class Service: NSObject {
    static let shared = Service()

    func fetchContact(completion: @escaping ([ContactStruct]?, Error?) -> ()) {
        let urlString = "http://gojek-contacts-app.herokuapp.com/contacts.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([ContactStruct].self, from: data)
                
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
