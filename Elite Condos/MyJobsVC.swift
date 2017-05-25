//
//  MyJobsVC.swift
//  Elite Condos
//
//  Created by Khoa on 3/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import ProgressHUD
import Firebase

/**
 
 List all orders of a user ( customer ) base on status. User can click on different buttons to change the order's status.
 - Author: Khoa Nguyen
 
 */
class MyJobsVC: UIViewController {
    
//    @IBOutlet weak var segment: UISegmentedControl!
    
    /**
       UITableView
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var tableView: UITableView!
    
    /**
     List of orders. We will download orders from Firebase and store to this variable
     - Author: Khoa Nguyen
     
     */
    var orders = [Order]()
    
    /**
    
     Supplier's name
     - Author: Khoa Nguyen
     
     */
    
    
    var supplierName = ""
    
    /**
     
     The built-in function of UIViewController. This function executes after a screen was loaded
     
     - Author: Khoa Nguyen
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
     
        fetchOrders(orderStatus: ORDER_STATUS.NOTACCEPTED.hashValue)
        
    }
    
    /**
     Fetch orders base on their status. Then refresh tableview to show new data.
     - Parameter orderStatus: The status of order
     - Author: Khoa Nguyen
     
     */
    
    func fetchOrders(orderStatus: Int){
        
        ProgressHUD.show("Đang tải dữ liệu...")
        FirRef.ORDERS.queryOrdered(byChild: "customerId").queryEqual(toValue: Api.User.currentUid()).observe(.value, with: { (snapshots) in
            if let snapshots = snapshots.children.allObjects as? [FIRDataSnapshot]{
                self.orders.removeAll()
                self.tableView.reloadData()
                for orderSnapshot in snapshots{
                    if let dict = orderSnapshot.value as? [String:Any]{
                        if let status = dict["status"] as? Int{
                            if status == orderStatus {
                               
                                let order = Order(id: orderSnapshot.key, data: dict)
                                self.orders.append(order)
                            }
                        }
                    }
                    
                }
                self.tableView.reloadData()
                ProgressHUD.dismiss()
            }
        })
        
        
    }
    
    /**
     Reload tableview with new orders with status: ***NOTACCEPTED***
     - Parameter sender: The button when the user presses
     - Author: Khoa Nguyen
     
     */
    
    
    @IBAction func waitingBtn(_ sender: Any) {
        fetchOrders(orderStatus: ORDER_STATUS.NOTACCEPTED.hashValue)
    }
    
    /**
     Reload tableview with new orders with status: ***ONGOING***
     - Parameter sender: The button when the user presses
     - Author: Khoa Nguyen
     
     */
    
    @IBAction func ongoingBtn(_ sender: Any) {
        fetchOrders(orderStatus: ORDER_STATUS.ONGOING.hashValue)
    }
    
    /**
     Reload tableview with new orders with status: ***REJECTED***
     - Parameter sender: The button when the user presses
     - Author: Khoa Nguyen
     
     */
    
    @IBAction func rejectedBtn_TouchInside(_ sender: Any) {
        fetchOrders(orderStatus: ORDER_STATUS.REJECTED.hashValue)
    }
    
    /**
     Reload tableview with new orders with status: ***CANCEL***
     - Parameter sender: The button when the user presses
     - Author: Khoa Nguyen
     
     */
    
    @IBAction func cancelBtn(_ sender: Any) {
        fetchOrders(orderStatus: ORDER_STATUS.CANCEL.hashValue)
    }
    
    /**
     Reload tableview with new orders with status: ***FINISHED***
     - Parameter sender: The button when the user presses
     - Author: Khoa Nguyen
     
     */
    
    @IBAction func finishBtn(_ sender: Any) {
        fetchOrders(orderStatus: ORDER_STATUS.FINISHED.hashValue)
    }
    
    /**
     Prepare data and logic code when it's about to move to next screen
     - Parameter segue: From this screen, we just can go to MyJobToPaymentConfimation
     - Parameter sender: sender will be a Dictionary with order's data
     - Author: Khoa Nguyen
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyJobToPaymentConfimation"{
            if let paymentVC = segue.destination as? PaymentConfirmationVC{
                if let data = sender as? [String:Any]{
                    if let orderId = data["orderId"] as? String{
                        paymentVC.orderId = orderId
                    }
                    if let supplierName = data["supplierName"] as? String{
                        paymentVC.supplierName = supplierName
                    }
                    if let serviceName = data["serviceName"] as? String{
                        paymentVC.serviceName = serviceName
                    }
                    if let supplierId = data["supplierId"] as? String{
                        paymentVC.supplierId = supplierId
                    }
                }
            }
        }
    }
    
    /**
     Go back to previous screen
     - Author: Khoa Nguyen
     
     */
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MyJobsVC: Customer_OrderCellDelegate{
    
    /**
     
     When a cell downloads order's information. It will fetch the supplier's name base on supplier's ID. When this process finish, the cell will notify us so that we can use the supplier's name.
     
     - Parameter name: The supplier's name
     - Author: Khoa Nguyen
     
     */
    
    func getSupplierName(name: String) {
        supplierName = name
    }
    
}

extension MyJobsVC: UITableViewDataSource{
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     the number of section in the tableview
     
     - Author: Khoa Nguyen
     
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     the number of rows in a section in the tableview
     
     - Author: Khoa Nguyen
     
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     what UIs will be displayed in a row in the tableview
     
     - Author: Khoa Nguyen
     
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
            cell.delegate = self
            cell.order = orders[indexPath.row]
            return cell
    }
}

extension MyJobsVC: UITableViewDelegate{
    
    /**
    
     The built-in function of UITableViewDelegate. This function executes when user clicks on a specific row.
     
     - Author: Khoa Nguyen
     
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let status = orders[indexPath.row].status
        if status == ORDER_STATUS.ONGOING.hashValue {
            let senderData: [String:String] = [
                "orderId": self.orders[indexPath.row].id ?? "",
                "supplierName": supplierName,
                "serviceName": self.orders[indexPath.row].serviceName ?? "",
                "supplierId": self.orders[indexPath.row].supplierId ?? ""
            ]
            
            self.performSegue(withIdentifier: "MyJobToPaymentConfimation", sender: senderData)
        }
        
       
        
        
    }
}




