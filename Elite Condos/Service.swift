//
//  Service.swift
//  Elite Condos
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation

/**
 We follow MVC model.
 This class is for data model: Service
 - Author: Khoa Nguyen
 
 */
class Service {
    
    /**
     Service's id
     - Author: Khoa Nguyen
     
     */
     var serviceId : String?
    
    /**
     Service's name
     - Author: Khoa Nguyen
     
     */
     var name : String?
    
    /**
     Supplier's ID
     - Author: Khoa Nguyen
     
     */
     var supplierId : String?
    
    
//    var serviceId : String{
//        return _serviceId
//    }
//    var name : String{
//        return _name
//    }
//    private var supplierId : String{
//        return _supplierId
//    }
    /**
     The constructor.
     - Parameter id: The id of service
     - Parameter data: A ***Dictionary*** with service's data. We need to unwrap it.
     - Author: Khoa Nguyen
     
     */
    init(id : String, data : Dictionary<String,Any>) {
        serviceId = id
        if let name = data["name"] as? String{
            self.name = name
        }
        if let supplierId = data["supplierId"] as? String{
            self.supplierId = supplierId
        }
        
    }
    
    
}
