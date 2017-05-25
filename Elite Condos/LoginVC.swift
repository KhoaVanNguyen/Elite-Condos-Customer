//
//  LoginVC.swift
//  Elite Condos
//
//  Created by Hoang on 11/14/16.
//  Copyright © 2016 Hoang. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD
class LoginVC: UIViewController {

    /**
     TextField lưu mật khẩu đăng nhập
     - Author: Hoang Phan
     */
    @IBOutlet weak var passwordTF: FancyField!
    /**
     TextField lưu email đăng nhập
     - Author: Hoang Phan
     */
    @IBOutlet weak var emailTF: FancyField!
    /**
     Button trở về màn hình trước
     - Author: Hoang Phan
     */
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       
    }
    /**
     Hàm mặc định, load xong rồi thực hiện
     - Author: Hoang Phan
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.delegate = self
        emailTF.delegate = self
    }
    /**
     Button đăng nhập
     - Author: Hoang Phan
     */
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    /**
     Hàm đăng nhập
     - Author: Hoang Phan
     */
    func login(){
        ProgressHUD.show("Đang đăng nhập")
        
        guard let email = emailTF.text, email != "" else {
            showAlert(title: SIGN_IN_ERROR, message: SIGN_IN_ERROR_EMAIL)
            ProgressHUD.dismiss()
            return
        }
        guard let password = passwordTF.text, password != "" else {
            showAlert(title: SIGN_IN_ERROR, message: SIGN_IN_ERROR_PASSWORD)
            ProgressHUD.dismiss()
            return
        }
        
        Api.User.login(email: email, password: password, onSuccess: {
            ProgressHUD.showSuccess("Đăng nhập thành công!")
            self.performSegue(withIdentifier: "LoginToHome", sender: nil)
        }) { (error) in
            ProgressHUD.showError(error)
        }
        

    }
    /**
     Đã bắt đầu chạm ra ngoài thì tắt bàn phím xuống
     - Author: Hoang Phan
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        passwordTF.resignFirstResponder()
//        return true
//    }
    /**
     Hiển thị thông báo ra màn hình
     - Author: Hoang Phan
     */
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)


        present(alert, animated: true, completion: nil)
        
    }
}
extension LoginVC: UITextFieldDelegate{
    /**
     Kiểm tra khi ấn enter (return) thì trỏ chuột đang ở đâu, nếu đang ở email textfield thì trỏ chuột chuyển xuống password textField, còn nếu đang ở password textField thì sẽ chạy hàm login.
     - Author: Hoang Phan
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            print("email")
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF{
            self.login()
        }
        return false
        
    }
}
