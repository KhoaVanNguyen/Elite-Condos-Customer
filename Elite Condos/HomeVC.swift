//
//  HomeVC.swift
//  Elite Condos
//
//  Created by Khoa on 3/15/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import FirebaseInstanceID
import FirebaseMessaging
import FirebaseDatabase


/**
 Home Sceen: The first screen that users see after they login
 - Author: Khoa Nguyen
 
 */

class HomeVC: UIViewController {

    /**
     UITableView
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var tableView: UITableView!
    
    /**
     List of services. We will download services from Firebase and store to this variable
     - Author: Khoa Nguyen
     
     */
    let services = getServiceData()
    
    /**
     
     The built-in function of UIViewController. This function executes before a screen was loaded
     
     - Author: Khoa Nguyen
     
     */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let token = UserDefaults.standard.value(forKey: "token") as? String{
            Api.User.updateTokenToDatabase(token: token, onSuccess: { 
                print("Update token in HomeVC with: \(token)")
            })
        }
    }
    
    /**
     
     The built-in function of UIViewController. This function executes after a screen was loaded
     
     - Author: Khoa Nguyen
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    /**
     Prepare data and logic code when it's about to move to next screen
     - Parameter segue: From this screen, we can go to SubCategoryVC
     - Parameter sender: sender will be a Dictionary with the main service users choose
     - Author: Khoa Nguyen
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if let subVC = segue.destination as? SubCategoryVC{
            if let data = sender as? [String:Any]{
                if let subServices = data["data"] as? [ServiceData]{
                    subVC.services = subServices
                }
                
                if let id = data["id"] as? String{
                    Api.Order.serviceId = id
                }
                
                if let title = data["title"] as? String{
                    subVC.navTitle = title
                    Api.Order.mainService = title
                }
            }
        }
    }
}

extension HomeVC: UITableViewDataSource{
    
    
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
        return services.count
    }
    
    /**
     
     The built-in function of UITableViewDataSource. This function determines
     what UIs will be displayed in a row in the tableview
     
     - Author: Khoa Nguyen
     
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as? ServiceCell{
            cell.service = services[indexPath.row]
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
}
extension HomeVC: UITableViewDelegate{
    
    /**
     
     The built-in function of UITableViewDelegate. This function executes when user clicks on a specific row.
     
     - Author: Khoa Nguyen
     
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeToSubCategory", sender:
            ["data": services[indexPath.row].subCategory! ,
            "title": services[indexPath.row].name,
            "id" : services[indexPath.row].id!
            ] as [String:Any]
        )
    }
}
