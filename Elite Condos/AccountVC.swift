//
//  AccountVC.swift
//  Elite Condos
//
//  Created by Hoàng on 3/20/17.
//  Copyright © 2017 Hoàng. All rights reserved.
//

import UIKit
import ProgressHUD
class AccountVC: UIViewController {
    /**
     Biến này để lưu avatar của user
     - Author: Hoang Phan
     */
    @IBOutlet weak var avatarImg: CircleImage!
    /**
     Biến này gõ tên của user
     - Author: Hoang Phan
     */
    @IBOutlet weak var nameTF: FancyField!
    /**
     Biến này để gõ số điện thoại của user
     - Author: Hoang Phan
     */
    @IBOutlet weak var phoneTF: FancyField!
    /**
     Biến này để gõ email của user
     - Author: Hoang Phan
     */
    @IBOutlet weak var emailTF: FancyField!
    /**
     Để chọn hình ảnh
     - Author: Hoang Phan
     */
    var imagePicker : UIImagePickerController!
    /**
     Hàm mặc định của swift, đã load rồi thì thực hiện
     - Author: Hoang Phan
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
       
    }
    /**
     Hàm mặc định của swift, trước khi load thì thực hiện
     - Author: Hoang Phan
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(changeAvatar))
        avatarImg.addGestureRecognizer(tapped)
        avatarImg.isUserInteractionEnabled = true
        ProgressHUD.show("")
        
        Api.User.downloadUserImage(onError: { (error) in
            print(error)
        }) { (img) in
            self.avatarImg.image = img
        }
        
        Api.User.loadUserData { (name, email, phone ) in
            self.updateUI(name: name, email: email, phone: phone)
            ProgressHUD.dismiss()
        }
        
        nameTF.delegate = self
        phoneTF.delegate = self
        emailTF.delegate = self
        
        
        
        FirRef.CUSTOMERS.child(Api.User.currentUid()).observe(.value, with: { (snapshot) in
            ProgressHUD.show("Updating....")
            if let dict  = snapshot.value as? [String:Any] {
                if let newAvatar = dict["avatarUrl"] as? String{
                    ProgressHUD.showSuccess("✓")
                    let url = URL(string: newAvatar)
                    self.avatarImg.sd_setImage(with: url)
                }
                
            }
        })

    }
    /**
     Hàm thay đổi avatar
     - Author: Hoang Phan
     */
    func changeAvatar(){
        present(imagePicker, animated: true, completion: nil)
    }
    /**
     Hàm update lại UI (Name, Email, Phone)
     - Author: Hoang Phan
     - Parameter name: tên của công ty
     - Parameter email: email của công ty
     - Parameter phone: phone của công ty
     */
    func updateUI(name: String, email: String, phone: String){
        nameTF.text = name
        emailTF.text = email
        phoneTF.text = phone
    }
    /**
     Chạm ra ngoài, thì tắt bàn phím (editting), hàm mặc định
     - Author: Hoang Phan
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     Hàm tắt màn hình cập nhật thông tin
     - Author: Hoang Phan
     */
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /**
     Hàm đăng xuất khỏi app
     - Author: Hoang Phan
     */
    @IBAction func signOut_TouchInside(_ sender: Any) {
        Api.User.signOut(onSuccess: { 
            let storyboard = UIStoryboard.init(name: "Start", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "StartVC")
            self.present(homeVC, animated: true, completion: nil)
        }) { (error) in
            print(error)
        }
        
    }
    /**
     Hàm hiển thị thông báo
     - Author: Hoang Phan
     */
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

}

/**
 Hàm chọn hình hiển thị
 - Author: Hoang Phan
 - Parameter picker: chọn hình
 - Parameter didFinishPickingMediaWithInfo: thông tin của hình đã được chọn
 */
extension AccountVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            Api.User.updateAvatar(image: img, onSuccess: { (successMessage) in
                self.avatarImg.image = img
            }, onError: { (error) in
                self.showAlert(title: "Lỗi", message: error)
            })
            
            
        }else{
            self.showAlert(title: "Lỗi", message: "Không thể chọn hình")
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    
}


extension AccountVC: UITextFieldDelegate{
    /**
     Có nhấn vào phím Return hay không?
     - Parameter textField: Một trong 3 text field nameTF, phoneTF, emailTF.
     - Returns: Bool, Trả về có nhấn vào phím return or không
     - Author: Hoang
     
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        return true
    }
    /**
     Text field đã được chỉnh sửa xong.
     - Parameter textField: Một trong 3 text field nameTF, phoneTF, emailTF.
     - Author: Hoang
     
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        ProgressHUD.show("Updating...")

        if textField == nameTF{
            // API here
            if let name = textField.text {
                Api.User.updateName(name: name, onSuccess: {
                    ProgressHUD.showSuccess("Đã cập nhật tên mới")
                })
                
            }
        }
        if textField == emailTF{
            
            if let email = textField.text {
                print(email)
                
                Api.User.updateEmail(email: email, onError: { (error) in
                    ProgressHUD.dismiss()
                    self.showAlert(title: "Lỗi", message: error)
                    return
                }, onSuccess: {
                    ProgressHUD.showSuccess("✓")
                    Api.User.signOut(onSuccess: {
                        let storyboard = UIStoryboard.init(name: "Start", bundle: nil)
                        let homeVC = storyboard.instantiateViewController(withIdentifier: "StartVC")
                        self.present(homeVC, animated: true, completion: nil)
                    }, onError: { (error) in
                        ProgressHUD.dismiss()
                        self.showAlert(title: "Lỗi", message: error)

                    })
                })
                
            }
            
        }
        if textField == phoneTF{
            if let phone = textField.text {
                Api.User.updatePhone(phone: phone, onSuccess: { 
                    ProgressHUD.showSuccess("Đã cập nhật số điện thoại mới")
                })
            }
            
        }
    }
}

