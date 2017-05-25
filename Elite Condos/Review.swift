//
//  Review.swift
//  Elite Condos
//
//  Created by Nguyen Hien on 4/16/17.
//  Copyright © 2017 Nguyen Hien. All rights reserved.
//

import Foundation
/**
 We follow MVC model.
 This class is for data model: Review
 - Author: Nguyen Hien
 
 */
class Review{
    /**
     username
     - Author: Nguyen Hien
     
     */
    var username: String?
    
    /**
     imgUrl
     - Author: Nguyen Hien
     
     */
    var imgUrl: String?
    /**
     moneyAmount
     - Author: Nguyen Hien
     
     */
    var moneyAmount: Double?
    /**
     review's content
     - Author: Nguyen Hien
     
     */
    var reviewContent: String?
    /**
     rating stars
     - Author: Nguyen Hien
     
     */
    var ratingStars: Double?
    
    /**
     review 's initial time.
     - Author: Nguyen Hien
     
     */
    var time: String?
    /**
     id of the review
     - Author: Nguyen Hien
     
     */
    var id: String
    
    /**
     The constructor.
     - Parameter id: The id of review
     - Parameter data: A ***Dictionary*** with review's data. We need to unwrap it.
     - Author:  Nguyen Hien
     
     */
    init(id: String, data: [String:Any] ) {
        
        self.id = id
        if let username = data["username"] as? String{
            self.username = username
        }
        if let imgUrl = data["imgUrl"] as? String{
            self.imgUrl = imgUrl
        }
        if let money = data["moneyAmount"] as? Double{
            self.moneyAmount = money
        }
        if let content = data["content"] as? String{
            self.reviewContent = content
        }
        if let stars = data["ratingStars"] as? Double{
            self.ratingStars = stars
        }
        if let time = data["time"] as? String{
            self.time = time
        }
    }
    
    
}
