//
//  ServiceData.swift
//  Elite Condos
//
//  Created by Khoa on 3/15/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation


/**
 The default service list
 - Author: Khoa Nguyen
 
 */
struct ServiceData{
    
    /**
     Service's id
     - Author: Khoa Nguyen
     
     */
    var id: String?
    /**
     Service's name
     - Author: Khoa Nguyen
     
     */
    var name: String!
    /**
     Service's image url
     - Author: Khoa Nguyen
     
     */
    var imgUrl: String!
    /**
     Service's sub category
     - Author: Khoa Nguyen
     
     */
    var subCategory: [ServiceData]?
    
    
    /**
     Constructor function
     - Author: Khoa Nguyen
     
     */
    
    init(name: String, imgUrl: String, subCategories: [ServiceData]?) {
        self.name = name
        self.imgUrl = imgUrl
        self.subCategory = subCategories
    }
    
    /**
     Constructor function
     - Author: Khoa Nguyen
     
     */
    
    init(id: String, name: String, imgUrl: String, subCategories: [ServiceData]?) {
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        self.subCategory = subCategories
    }
}


/**
 Helper function to return a array of available services
 - Author: Khoa Nguyen
 
 */
func getServiceData() -> [ServiceData]{
    // Electrical
    
    let e1 = ServiceData(name: "Emergency Electrician", imgUrl: "emergencyElectrician.jpg", subCategories: nil)
    
    let e2 = ServiceData(name: "Light & Switches", imgUrl: "lights.jpg", subCategories: nil)
    let e3 = ServiceData(name: "Sockets", imgUrl: "sockets.jpg", subCategories: nil)
    
    
   
    
    let p1 = ServiceData(name: "Emergency Plumbing", imgUrl: "EmergencyPlumbing.jpg", subCategories: nil)
    
    let p2 = ServiceData(name: "Blocked Brains", imgUrl: "BlockedBrains.jpg", subCategories: nil)
    
    let p3 = ServiceData(name: "Leaks & Drips", imgUrl: "LeaksDrips.jpg", subCategories: nil)
   
    let p4 = ServiceData(name: "Plumbing Installation", imgUrl: "PlumbingInstallation.jpg", subCategories: nil)
    let p5 = ServiceData(name: "Toilet Repairs", imgUrl: "ToiletRepairs.jpg", subCategories: nil)
    
    let a1 = ServiceData(name: "Washing Machine Repair", imgUrl: "WashingMachineRepair.jpg", subCategories: nil)
    let a2 = ServiceData(name: "Fridge Repair", imgUrl: "Fridge Repair.jpg", subCategories: nil)
    let a3 = ServiceData(name: "Gas Appliance Repair", imgUrl: "Gas Appliance Repair.jpg", subCategories: nil)
    
    
    
    let electricalService = ServiceData(id: "service01", name: "Electrical", imgUrl: "electrical.jpg", subCategories: [e1,e2,e3])
    
    let plumbing = ServiceData(id: "service02", name: "Pluming", imgUrl: "plumbing.png", subCategories: [p1,p2,p3,p4,p5])

    let appliances = ServiceData(id: "service03", name: "Appliances", imgUrl: "appliances.png", subCategories: [a1,a2,a3])
    
    
    
    let services = [appliances,electricalService,plumbing]
    return services

}
