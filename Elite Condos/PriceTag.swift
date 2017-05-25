//
//  PriceTag.swift
//  Elite Condos Supplier
//
//  Created by Khoa on 12/10/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation

/**
 We follow MVC PriceTag.
 This class is for data model: Supplier
 - Author: Khoa Nguyen
 
 */
class PriceTag {
    
    private var _id: String!
    private var _name: String!
    private var _price: Double!
    
    /**
     Pricetag's id
     - Author: Khoa Nguyen
     
     */
    var id: String{
        return _id
    }
    
    /**
     Tag name
     - Author: Khoa Nguyen
     
     */
    var name: String{
        return _name
    }
    
    /**
     Price
     - Author: Khoa Nguyen
     
     */
    var price: Double{
        return _price
    }
    /**
     The constructor.
     - Parameter id: The id of price tag
     - Parameter data: A ***Dictionary*** with pricetag's data. We need to unwrap it.
     - Author: Khoa Nguyen
     
     */
    init(id: String , data: Dictionary<String,Any> ) {
        
        self._id = id
        if let name = data["name"] as? String{
            self._name = name
        }
        
        if let price = data ["price"] as? Double?{
            self._price = price
        }
        
    }
    /**
     The constructor.
     - Parameter id: The id of price tag
     - Parameter name: The name tag
     - Parameter price: The price
     - Author: Khoa Nguyen
     
     */
    init(id: String, name: String, price: Double) {
        self._id = id
        self._name = name
        self._price = price
    }
    
    
}
