//
//  SubCategoryVC.swift
//  Elite Condos
//
//  Created by Khoa on 3/15/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

/**
 SubCategory Sceen: When users click on a service from Home Screen, this screen opens for them to choose sub service.
 - Author: Khoa Nguyen
 
 */

class SubCategoryVC: UIViewController {
    
    /**
     UITableView
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var tableView: UITableView!
    
    /**
     List of sub-services.
     - Author: Khoa Nguyen
     
     */
    var services: [ServiceData] = [ServiceData]()
   
    /**
     The title of this screen
     - Author: Khoa Nguyen
     
     */
    var navTitle = ""
    
    /**
     
     The built-in function of UIViewController. This function executes after a screen was loaded
     
     - Author: Khoa Nguyen
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = navTitle
        
    }
    
    
    /**
     Prepare data and logic code when it's about to move to next screen
     - Parameter segue: From this screen, we can go to Description Screen
     - Parameter sender: sender will be a Dictionary with the main service and sub-service users choose
     - Author: Khoa Nguyen
     
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let descriptionVC = segue.destination as? DescriptionVC{
            if let data = sender as? [String:Any]{
                if let main = data["main"] as? String{
                    descriptionVC.mainService = main
                    Api.Order.mainService = main
                }
                if let sub = data["sub"] as? String{
                    descriptionVC.subService = sub
                    Api.Order.subService = sub 
                }
            }
        }
    }
    
    
    
    
    
}



extension SubCategoryVC: UITableViewDataSource{
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as? SubCategoryCell{
            cell.service = services[indexPath.row]
            return cell
        }
        else{
            return UITableViewCell()
        }
        
    }

}

extension SubCategoryVC: UITableViewDelegate{
    
    /**
     
     The built-in function of UITableViewDelegate. This function executes when user clicks on a specific row.
     
     - Author: Khoa Nguyen
     
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SubCategoryToDescription", sender:
            ["main": navTitle ,
             "sub": services[indexPath.row].name ] )
    }
}
