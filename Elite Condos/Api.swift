//
//  Api.swift
//  Elite Condos
//
//  Created by Hien on 3/17/17.
//  Copyright © 2017 Hien. All rights reserved.
//

import Foundation

/**
 
 All the API of the app
 - Author: Hien Nguyen
 
*/

struct Api {
    
    /**
     
     Order API
     - Author: Hien Nguyen
     
     */
    
    static var Order = OrderApi()
    
    /**
     
     User API
     - Author: Hien Nguyen
     
     */
    
    static var User = UserApi()
    
    /**
     
     Supplier API
     - Author: Hien Nguyen
     
     */
    
    static var Supplier = SupplierApi()
}
