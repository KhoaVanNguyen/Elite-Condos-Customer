//
//  CustomerSignUpVC.swift
//  Elite Condos
//
//  Created by Khoa on 11/14/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD
class SignUpVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    /**
     TextField lưu mật khẩu người dùng đăng ký
     - Author: Hoang Phan
     */
    @IBOutlet weak var passwordTF: FancyField!
    /**
     TextField lưu số điện thoại người dùng đăng ký
     - Author: Hoang Phan
     */
    @IBOutlet weak var phoneTF: FancyField!
    /**
     TextField lưu email người dùng đăng ký
     - Author: Hoang Phan
     */
    @IBOutlet weak var emailTF: FancyField!
    /**
     TextField lưu tên người dùng đăng ký
     - Author: Hoang Phan
     */
    @IBOutlet weak var nameTF: FancyField!
    /**
     Profile của người dùng
     - Author: Hoang Phan
     */
    @IBOutlet weak var profileImage: CircleImage!
    
    /**
     Avatar của người dùng
     - Author: Hoang Phan
     */
    @IBOutlet weak var avatarImage: CircleImage!
    
    /**
     Biến lưu avatar picker người dùng đăng ký
     - Author: Hoang Phan
     */
    var imagePicker : UIImagePickerController!
    /**
     Biến lưu avatar picker người dùng đã được chọn chưa
     - Author: Hoang Phan
     */
    var pickedImage = false
    /**
     Hàm mặc định, load xong sẽ thực hiện
     - Author: Hoang Phan
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        setupTextField()
        
    }
    /**
     Hàm cài đặt TextField, giao quyền lại cho TextField
     - Author: Hoang Phan
     */
    func setupTextField(){
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        phoneTF.delegate = self
        
        nameTF.tag = 0
        emailTF.tag = 1
        passwordTF.tag = 2
        phoneTF.tag = 3
    }
    /**
     Hàm chọn hình hiển thị
     - Author: Hoang Phan
     - Parameter picker: chọn hình
     - Parameter didFinishPickingMediaWithInfo: thông tin của hình đã được chọn
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            avatarImage.image = image
            pickedImage = true
        }else {
            self.showAlert(title: "Lỗi", message: "Không thể chọn hình")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    /**
     Hàm kiểm tra thông tin và đăng ký tài khoản
     - Author: Hoang Phan
     */
    @IBAction func signUp(_ sender: Any) {
        
        guard pickedImage == true else {
            showAlert(title: APP_NAME, message: "Vui lòng chọn hình profile")
            return
        }
        
        guard let name = nameTF.text, name != ""
            else {
                showAlert(title: SIGN_UP_ERROR, message: SIGN_UP_ERROR_NAME)
                return
        }
        guard let email = emailTF.text, let password = passwordTF.text, email != "",  password != ""
            else {
                showAlert(title: SIGN_UP_ERROR, message: SIGN_UP_ERROR_EMAIL_PASSWORD )
                return
        }
        
        guard let phone = phoneTF.text, phone != ""
            else {
                showAlert(title: SIGN_UP_ERROR, message: SIGN_UP_ERROR_PHONE)
                return
        }
        

        ProgressHUD.show("Creating account")
        Api.User.signUp(name: name, email: email, password: password, phone: phone, avatarImg: avatarImage.image!, onSuccess: {
            
            ProgressHUD.dismiss()
            
            let alert = UIAlertController(title: APP_NAME, message: "Đăng Ký Thành Công, tự động đăng nhập", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.performSegue(withIdentifier: "SignUpToHome", sender: nil)
            })
            
            alert.addAction(okAction)
            
            ProgressHUD.dismiss()
            self.present(alert, animated: true, completion: nil)

            
            
        }) { (error) in
            ProgressHUD.dismiss()
            self.showAlert(title: APP_NAME, message: error)
        }
        
        
    }
    /**
     Hàm mặc định của swift, hiển thị thông báo ra ngoài màn hình
     - Author: Hoang Phan
     */
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    /**
     Hàm click để chọn avatar
     - Author: Hoang Phan
     */
    @IBAction func pickAvatar(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    /**
     Hàm quay trở lại màn hình trước
     - Author: Hoang Phan
     */
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpVC: UITextFieldDelegate{
    /**
     Nhấn enter thì xác định con trỏ đang ở vị trí textField nào, và chuyển xuống textField có tag lớn hơn.
     - Returns: Bool,
     - Author: Hoang Phan
     - Parameter textField: Một trong 4 text field nameTF, phoneTF, emailTF, passwordTF
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTF = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextTF.becomeFirstResponder()
            nextTF.updateFocusIfNeeded()
        }
        else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}
