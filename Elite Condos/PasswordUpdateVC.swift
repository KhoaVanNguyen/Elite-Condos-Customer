//
//  PasswordUpdateVC.swift
//  Elite Condos
//
//  Created by Hoang on 3/30/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import UIKit
import ProgressHUD
class PasswordUpdateVC: UIViewController {
    /**
     TextField điền mật khẩu mới
     - Author: Hoang Phan
     */
    @IBOutlet weak var passwordTF: FancyField!
    /**
     Hàm mặc định của swift, load xong sẽ thực hiện
     - Author: Hoang Phan
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    /**
     Button khi ấn vào button mật khẩu sẽ được thay đổi.
     - Author: Hoang Phan
     */
    @IBAction func updatePassword_TouchInside(_ sender: Any) {
        guard let password = passwordTF.text, password != "" else {
            showAlert(title: APP_NAME, message: "Vui lòng nhập mật khẩu mới")
            return
        }
        
        

        updatePassword(password: password, onError: { (error) in
            self.showAlert(title: APP_NAME, message: error)
        }) {
            Api.User.signOut(onSuccess: {
              
                let storyboard = UIStoryboard.init(name: "Start", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "StartVC")
                self.present(homeVC, animated: true, completion: nil)
            }) { (error) in
                print(error)
            }

        }
    }
    /**
     Hàm cập nhật lại mật khẩu.
     - Author: Hoang Phan
     - Parameter password: Mật khẩu từ TextField
     - Parameter onError: Hàm lấy lỗi về để hiển thị
     - Parameter onSuccess: Nếu thành công thì cập nhật mật khẩu lên dữ liệu
     */
    func updatePassword(password: String, onError: @escaping (String) -> Void,
                        onSuccess: @escaping () -> Void){
        Api.User.updatePassword(password: password) { (error) in
            onError(error)
            return
        }
        
        onSuccess()

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
