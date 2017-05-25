//
//  StartVC.swift
//  Elite Condos
//
//  Created by Khoa on 11/14/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import FirebaseAuth
class StartVC: UIViewController {
    
    /**
     Hàm mặc định của swift, load xong sẽ thực hiện
     - Author: Hoang Phan
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /**
     Hàm mặc định của swift, sau khi xuất hiện lại màn hình
     - Author: Hoang Phan
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ( FIRAuth.auth()?.currentUser != nil  ){
            performSegue(withIdentifier: "StartVCToHome", sender: nil)
        }
        
    }
    
    
    
}
