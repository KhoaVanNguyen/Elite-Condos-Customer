//
//  ReviewVC.swift
//  Elite Condos
//
//  Created by Hien on 4/10/17.
//  Copyright © 2017 Hien. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class ReviewVC: UIViewController {
    
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var reviewTF: FancyField!
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var rating: CosmosView!
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    
    @IBOutlet weak var supplierLogo: UIImageView!
    
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var priceLbl: UILabel!
    
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var serviceNameLbl: UILabel!
    
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    @IBOutlet weak var supplierNameLbl: UILabel!
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    
    var orderId = ""
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    var serviceName = ""
    
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    var price = 0.0
    
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    var supplierName = ""
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    var employeeImge = ""
    /**
     FancyField
     - Author:  Nguyen Hien
     
     */
    var supplierId = ""
    
    /**
     
     The built-in function of UIViewController. This function executes after a screen was loaded
     
     - Author:  Nguyen Hien
     
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        supplierNameLbl.text = supplierName
        serviceNameLbl.text = serviceName
        priceLbl.text = "\(price)"
        
        
        Api.Supplier.downloadImage(id: supplierId, onError: { (error) in
            print(error)
        }) { (img) in
            self.supplierLogo.image = img
        }
    }
    
    
    /**
     Add review when user touch inside
     - Parameter sender: The button when the user touch inside
     - Author: Nguyen Hien
     
     */
    @IBAction func addReview_TouchInside(_ sender: Any) {
        ProgressHUD.show("Đang đăng nhận xét...")
        /**
         Review of the user
         - Author: Nguyen Hien
         
         */
        guard let review = reviewTF.text, review != "" else {
            showAlert(title: "Error", message: "Vui lòng điền nội dung đánh giá")
            return
        }
        /**
         username
         - Author: Nguyen Hien
         
         */
        let username = FIRAuth.auth()?.currentUser?.email
        /**
         current Id
         - Author: Nguyen Hien
         
         */
        let currenId = Api.User.currentUid()
        
        Api.User.getImageProfileUrl { (imgUrl) in
            let reviewData: [String:Any] =
                [
                    "time" : getCurrentTime(),
                    "customerId" : currenId,
                    "username": username! ,
                    "moneyAmount": self.price,
                    "ratingStars" : self.rating.rating,
                    "content" : review,
                    "imgUrl": imgUrl
            ]
            
            Api.Order.addReview(supplierId: self.supplierId, orderId: self.orderId, reviewData: reviewData, onSuccess: {
                self.showAlert(title: "✓", message: "Bạn đã thêm nhận xét thành công, xin cảm ơn!")
                ProgressHUD.dismiss()
            })
            
            
            
        }
        
    }
    
    /**
     Go back to previous screen
     - Parameter sender: The button when the user presses
     - Author: Nguyen Hien
     
     */
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     show Alert
     - Parameter title: The title of Alert
     - Parameter message: The message of Alert
     - Author: Nguyen Hien
     
     */
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler:  {
            action in
            self.performSegue(withIdentifier: "ReviewToHome", sender: nil)
        })
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    /**
     - Parameter sender: The button when the user skip_TouchInside
     - Author: Nguyen Hien
     
     */
    @IBAction func skip_TouchInside(_ sender: Any) {
        performSegue(withIdentifier: "ReviewToHome", sender: nil)
    }
    
}
