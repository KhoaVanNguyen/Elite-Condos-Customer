//
//  Constant.swift
//  Elite Condos
//
//  Created by Khoa on 11/14/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation

let APP_NAME = "Elite Condos"


let SHADOW_GRAY = 120.0 / 255.0
let DEFAULT_CUSTOMER_AVATAR = "https://firebasestorage.googleapis.com/v0/b/elite-condos.appspot.com/o/customer_avatar%2Favatar-user.png?alt=media&token=e39561de-252b-47df-99a2-ee860ca9a995"

let DEFAULT_SUPPLIER_LOGO = "https://firebasestorage.googleapis.com/v0/b/elite-condos.appspot.com/o/supplier_images%2Felite_condos_supplier_default.jpg?alt=media&token=79743a3b-a5d4-47d1-afd0-f8dad2e9ff07"



/**
 The status of order
 - Author: Khoa Nguyen
 
 */

enum ORDER_STATUS{
    /**
     In waiting mode or supplier doesn't accept
     - Author: Khoa Nguyen
     
     */
    case NOTACCEPTED
    
    /**
     Supplier accepts order, but order isn't finish
     - Author: Khoa Nguyen
     
     */
    
    case ONGOING
    
    /**
     Order is canceld by supplier
     - Author: Khoa Nguyen
     
     */
    
    case CANCEL
    
    /**
     Order is finished
     - Author: Khoa Nguyen
     
     */
    
    case FINISHED
    /**
     Order is rejected by supplier
     - Author: Khoa Nguyen
     
     */
    case REJECTED
}


/**
 Get the current time with date format: `"dd/MM/yyyy HH:mm"
`
 - Parameter length: Length of the string
 - Returns: a random string
 - Author: Khoa Nguyen
 
 */
func getCurrentTime() -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    let dateInFormat = dateFormatter.string(from: Date())
    return dateInFormat
}

/**
 1. Create a date with format : `"dd/MM/yyyy HH:mm"`
 2. Return a string from the date above
 
 The main idea is check whether we can create a date from a string or not? Then yes, return it in a string format to display to UI Label
 
 
 - Parameter str: A string date, ex: `21/05/2017 17:06`
 - Returns: A string date
 - Author: Khoa Nguyen
 
 */

func getTimeStringFrom(str: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy HH:mm"
    let date = formatter.date(from: str)
    let dateInFormat = formatter.string(from: date ?? Date())
    return dateInFormat
    
}






