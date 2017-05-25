//
//  OrderDescription.swift
//  Elite Condos
//
//  Created by Khoa on 3/16/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import CoreLocation

/**
 We follow MVC PriceTag.
 This class is for data model: OrderDescription
 - Author: Khoa Nguyen
 
 */
class OrderDescription{
    /**
     Description of order
     - Author: Khoa Nguyen
     
     */
    var description: String
    /**
     List of photos
     - Author: Khoa Nguyen
     
     */
    var photos: [String]!
    /**
     Address of customer
     - Author: Khoa Nguyen
     
     */
    var address: String
    /**
     Location of user
     - Author: Khoa Nguyen
     
     */
    
    var location: CLLocationDegrees
    /**
     The description.
     - Parameter description: Description of order
     - Parameter photos: List of photos
     - Parameter address: Address of customer
     - Parameter location: Location of user
     - Author: Khoa Nguyen
     
     */
    init(description: String, photos: [String], address: String,location: CLLocationDegrees ) {
        self.description = description
        self.photos = photos
        self.address = address
        self.location = location
    }
}
