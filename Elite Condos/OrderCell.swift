//
//  Customer_OrderCell.swift
//  Elite Condos
//
//  Created by Khoa on 11/26/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Firebase


/**

 We have to download supplier's name base on supplier's id.
 When we finish this job, we need to notify to tableview to update the name.
 - Author: Khoa Nguyen
 
 */

protocol Customer_OrderCellDelegate {
    func getSupplierName(name: String)
}


/**
 We follow MVC model.
 This class is subclass of UITableViewCell
 This class is for Order Cell that is used tableview of MyJobVC
 - Author: Khoa Nguyen
 
 */

class OrderCell: UITableViewCell {
    
    
    /**
     Order's initial time
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var timeLbl: UILabel!
    
    /**
     Order's id
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var orderId: UILabel!
    
    /**
     Supplier's name
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var supplierName: UILabel!
    
    /**
     Supplier's logo
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var logo: CircleImage!
    
    /**
     Service's name
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var serviceNameLbl: UILabel!
    
   
    /**
     Delegation is a design pattern that enables a class or structure to delegate some of its responsibilities to an instance of another type.
     In this case: We need to delegate the `getSupplierName(_:)` to other class.
     - Author: Khoa Nguyen
     
     */
    
    var delegate: Customer_OrderCellDelegate?
    
    
    /**
     A feature of Swift, when this variable has value, a function will executes immediately
     - Author: Khoa Nguyen
     
     */
    var order: Order?{
        didSet{
            updateView()
        }
    }
    
    /**
     Initialization code
     - Author: Khoa Nguyen
     
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /**
     Set service's name, order's id, supplier's logo and supplier's name for controls.
     - Author: Khoa Nguyen
     
     */
    
    func updateView(){
        
        serviceNameLbl.text = order?.serviceName
        orderId.text = "#\((order?.id)!)"
        
        if order?.time != nil {
            timeLbl.text = getTimeStringFrom(str: (order?.time)!)
        }
        
        
        // download supplier Image
        
        
        if order?.supplierId != nil {
            Api.Supplier.getSupplierName(id: (order?.supplierId)!) { (name) in
                self.supplierName.text = name
                self.delegate?.getSupplierName(name: name)
            }
            Api.Supplier.downloadImage(id: (order?.supplierId)!, onError: { (error) in
                print(error)
            }) { (img) in
                self.logo.image = img
                
            }
        }
        
    }
    
}
