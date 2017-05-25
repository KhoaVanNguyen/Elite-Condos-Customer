//
//  Supplier.swift
//  Elite Condos
//
//  Created by Khoa on 11/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import Firebase

/**
 We follow MVC model.
 This class is for data model: Supplier
 - Author: Khoa Nguyen
 
 */
class Supplier {
    /**
     Supplier's id
     - Author: Khoa Nguyen
     
     */
    var id : String?
    /**
     Supplier's name
     - Author: Khoa Nguyen
     
     */
    var name : String?
    /**
     Supplier's address
     - Author: Khoa Nguyen
     
     */
    var address : String?
    /**
     Supplier's logo
     - Author: Khoa Nguyen
     
     */
    
    var logo : String?
    /**
     Supplier's phone
     - Author: Khoa Nguyen
     
     */
    var phone: String?
    
    /**
     Supplier's email
     - Author: Khoa Nguyen
     
     */
    
    var email: String?
    /**
     Supplier's stars
     - Author: Khoa Nguyen
     
     */
    var stars: String?
    
    /**
     Supplier's distance
     - Author: Khoa Nguyen
     
     */
    
    var distance: Double?
    //var serviceRef : FIRDatabaseReference!
    /**
     The constructor.
     - Parameter id: The id of supplier
     - Parameter data: A ***Dictionary*** with supplier's data. We need to unwrap it.
     - Author: Khoa Nguyen
     
     */
    init(id : String, data : Dictionary<String, Any>) {
        self.id = id
        if let name = data["name"] as? String{
            self.name = name
        }
        if let address = data["address"] as? String{
            self.address = address
        }
        if let logo = data["avatarUrl"] as? String{
            self.logo = logo
        }
        if let email = data["email"] as? String{
            self.email = email
        }
        if let phone = data["phone"] as? String{
            self.phone = phone
        }
        
        
        
    }
    
    
}
