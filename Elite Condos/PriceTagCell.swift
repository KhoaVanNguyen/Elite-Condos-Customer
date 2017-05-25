//
//  PriceTagCell.swift
//  Elite Condos
//
//  Created by Khoa on 4/10/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
/**
 We follow MVC model.
 This class is subclass of UITableViewCell
 
 - Author: Khoa Nguyen
 
 */

class PriceTagCell: UITableViewCell {
    
    /**
     Name label
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var nameLbl : UILabel!
    
    /**
     Price label
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var priceLbl : UILabel!
    
    /**
     A feature of Swift, when this variable has value, a function will executes immediately
     - Author: Khoa Nguyen
     
     */
    var priceTag: PriceTag?{
        didSet{
            updateView()
        }
    }
    
    
    /**
     Set name and price 
     - Author: Khoa Nguyen
     
     */
    
    func updateView(){
        nameLbl.text = priceTag?.name
        
        if let price = priceTag?.price {
             priceLbl.text = "\(price)"
        }
       
    }
    
    
}

