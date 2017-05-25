//
//  SupplierCell.swift
//  Elite Condos
//
//  Created by Khoa on 11/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD


/**
 
  We have to notify to tableview to book the order
 - Author: Khoa Nguyen
 
 */

protocol SupplierCellDelegate {
    
    /**
     
     We have to notify to tableview to book the order
     - Author: Khoa Nguyen
     
     */
    func book(supplierId: String)
}

class SupplierCell: UITableViewCell {
    /**
     Rating view
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var rating: CosmosView!
    
    /**
     Distance label
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var distance: UILabel!
    
    /**
     Name of the supplier
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var nameLbl: UILabel!
    
    /**
     Supplier's logo
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var logoImage: UIImageView!
    /**
     Delegation is a design pattern that enables a class or structure to delegate some of its responsibilities to an instance of another type.
     In this case: We need to delegate the `book(supplierId: String)` to other class.
     - Author: Khoa Nguyen
     
     */
    var delegate: SupplierCellDelegate?
    
    /**
     A feature of Swift, when this variable has value, a function will executes immediately
     - Author: Khoa Nguyen
     
     */
    var supplier: Supplier?{
        didSet{
            updateView()
        }
    }
    /**
     Set information for a supplier
     - Author: Khoa Nguyen
     
     */
    func updateView(){
        ProgressHUD.show("Loading...")
  
        rating.isUserInteractionEnabled = false
        
        
        if let distanceInMeters = supplier?.distance {
            
            
            let distanceString = String(format: "%.2f", distanceInMeters/1000)
            distance.text = "\(distanceString)Km"
        }
        
       
        
        nameLbl.text = supplier?.name
        
        if let imgUrl = supplier?.logo {
            let url = URL(string: imgUrl)
            logoImage.sd_setImage(with: url)
        }
    
        Api.Supplier.getTotalReviewScore(supplierId: (supplier?.id)!) { (score) in
            self.rating.rating = score
        }
        
        
        
        ProgressHUD.dismiss()
        
    }
    @IBAction func book_TouchUpInside(_ sender: Any) {

    
        
        if let supplierId = supplier?.id {
            delegate?.book(supplierId: supplierId)
        }
    }
}




