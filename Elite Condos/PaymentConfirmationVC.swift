//
//  PaymentConfirmationVC.swift
//  Elite Condos
//
//  Created by Nguyen Hien on 4/10/17.
//  Copyright © 2017 Nguyen Hien. All rights reserved.
//

import UIKit
import Firebase

/**
 User can click on  button to Confirm the order's payment.
 - Author: Nguyen Hien
 
 */

class PaymentConfirmationVC: UIViewController {
    
    /**
     FancyBtn
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var confirmButton: FancyBtn!
    
    /**
     UILabel to display oder's price
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var totalLbl: UILabel!
    
    /**
     orderId
     - Author:  Nguyen Hien
     
     */
    var orderId = ""
    /**
     total
     - Author:  Nguyen Hien
     
     */
    var total = 0.0
    /**
     supplier'sName
     - Author:  Nguyen Hien
     
     */
    var supplierName = ""
    /**
     service'sName
     - Author:  Nguyen Hien
     
     */
    var serviceName = ""
    
    /**
     supplier's Id
     - Author:  Nguyen Hien
     
     */
    var supplierId = ""
    
    /**
     UITableView
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var tableView: UITableView!
    var priceTags = [PriceTag]()
    
    /**
     
     The built-in function of UIViewController. This function executes after a screen was loaded
     
     - Author:  Nguyen Hien
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        print("orderId: \(orderId)")
        
        self.confirmButton.isHidden = true
        
        FirRef.ORDERS.child(orderId).child("pricetag").observe(.value, with:  { (snapshot) in
            
            self.priceTags = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    if let snapData = snap.value as? Dictionary<String,Any>{
                        
                        let priceTag = PriceTag(id: snap.key, data: snapData)
                        self.priceTags.append(priceTag)
                    }
                }
                self.tableView.reloadData()
                
            }
        })
        FirRef.ORDERS.child(orderId).child("total").observe(.value, with: { (snapshot) in
            if let totalPrice = snapshot.value as? Double{
                self.total  = totalPrice
                self.totalLbl.text = "\(totalPrice) VNĐ"
                self.confirmButton.isHidden = false
            }
        })
        
        
        
        
        
        
        //        Api.Order.observePriceTag(orderId: orderId) { (pricetag) in
        //            self.priceTags.append(pricetag)
        //            self.calulateTotal()
        //        }
    }
    
    /**
     confirmPayment when user touch inside
     - Parameter sender: The button when the user touch inside
     - Author: Nguyen Hien
     
     */
    
    @IBAction func confirm_TouchInside(_ sender: Any) {
        Api.Order.confirmPayment(orderId: orderId, totalPrice: total) {
            
            let senderData: [String:Any] = [
                "orderId": self.orderId,
                "supplierName": self.supplierName,
                "serviceName": self.serviceName,
                "total": self.total,
                "supplierId": self.supplierId
            ]
            
            self.performSegue(withIdentifier: "PaymentConfirmationToReview", sender: senderData)
        }
    }
    
    /**
     Prepare data and logic code when it's about to move to next screen
     - Parameter segue: From this screen, we just can go to PaymentConfirmationToReview
     - Parameter sender: sender will be a Dictionary with order's data
     - Author: Nguyen Hien
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PaymentConfirmationToReview"{
            if let reviewVC = segue.destination as? ReviewVC{
                
                if let data = sender as? [String:Any]{
                    if let orderId = data["orderId"] as? String{
                        reviewVC.orderId = orderId
                    }
                    if let serviceName =  data["serviceName"] as? String{
                        reviewVC.serviceName = serviceName
                    }
                    if let supplierName = data["supplierName"] as? String{
                        reviewVC.supplierName = supplierName
                    }
                    if let supplierId = data["supplierId"] as? String{
                        reviewVC.supplierId = supplierId
                    }
                    if let totalPrice = data["total"] as? Double{
                        reviewVC.price = totalPrice
                    }
                }
            }
        }
    }
}

extension PaymentConfirmationVC: UITableViewDataSource{
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     the number of section in the tableview
     
     - Author: Nguyen Hien
     
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     the number of rows in a section in the tableview
     
     - Author:  Nguyen Hien
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceTags.count
    }
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     what UIs will be displayed in a row in the tableview
     
     - Author: Nguyen Hien
     
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTagCell", for: indexPath) as! PriceTagCell
        cell.priceTag = priceTags[indexPath.row]
        return cell
    }
    
}
