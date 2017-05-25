//
//  PasswordForgetVC.swift
//  Elite Condos
//
//  Created by Hoang on 3/30/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import UIKit
/**
 Quên mật khẩu
 - Author: Hoang Phan
 */

class PasswordForgetVC: UIViewController {

    /**
     TextField để nhập email, lấy lại mật khẩu
     - Author: Hoang Phan
     */
    @IBOutlet weak var emailTF: FancyField!
    /**
     Hàm mặc định của swift, load xong sẽ thực hiện
     - Author: Hoang Phan
     */
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /**
     Hàm kiểm tra email và reset mật khẩu
     - Author: Hoang Phan
     */
    @IBAction func forgetPassword_TouchInside(_ sender: Any) {
        
        guard let email = emailTF.text, email != "" else {
            showAlert(title: APP_NAME, message: "Vui lòng nhập email")
            return
        }
        Api.User.forgetPassword(email: email, onError: { (error) in
            print(error)
        }, onSuccess: {
            self.showAlert(title: APP_NAME, message: "Vui lòng kiểm tra email để reset password!")
        })
    }
    /**
     Hàm mặc định của swift, hiển thị thông báo
     - Author: Hoang Phan
     */
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

    
   }
