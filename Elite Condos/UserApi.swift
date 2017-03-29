//
//  UserApi.swift
//  Elite Condos
//
//  Created by Khoa on 3/21/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import Firebase

class UserApi{
   
    
    func signOut(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void){
        do {
           try  FIRAuth.auth()?.signOut()
            onSuccess()
        } catch{
            onError("can't sign out")
        }
    }
    
    func uploadAvatar(avatarImg: UIImage,onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void ){
        
        if let imgData = UIImageJPEGRepresentation(avatarImg, 0.2){
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            DataService.ds.REF_CUSTOMER_AVATAR.child(imgUid).put(imgData, metadata: metadata, completion: { (metadata, error) in
                if error != nil{
                    onError(error.debugDescription)
                }else{
                    
                    if let avatarUrl = metadata?.downloadURL()?.absoluteString{
                        onSuccess(avatarUrl)
                    }
                }
            })
        }
    }
    
    func signUp(name: String, email: String, password: String, phone: String, avatarImg: UIImage, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void){
        
        uploadAvatar(avatarImg: avatarImg, onSuccess: { (imgUrl) in
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    
                    let errorDetail = (error as! NSError).localizedDescription
                    
                    onError(errorDetail)
                }
                if let user = user{
                    let userData = [
                        "name" : name,
                        "email" : email,
                        "phone" : phone,
                        "avatarUrl" : imgUrl
                    ]
                    DataService.ds.createFirebaseDBCutomer(uid: user.uid, userData: userData)
                    onSuccess()
                }
            })
            
        }) { (error) in
            onError(error)
        }
        
    }
    
    
    func loadUserData(completed: @escaping (String,String,String) -> Void){
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        DataService.ds.REF_CUSTOMERS.child(user.uid).observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:Any]{
                guard let phone = dict["phone"] as? String else{
                    return
                }
                guard let name = dict["name"] as? String else{
                    return
                }
                
//                let uid = FIRAuth.auth()?.currentUser?.uid
                
                let email = FIRAuth.auth()?.currentUser?.email
                
                completed(name, email!, phone)
                
                
                
                ///["phone": 01647778186, "name": Khoa, "email": user3@gmail.com, "avatarUrl": https://firebasestorage.googleapis.com/v0/b/elite-condos.appspot.com/o/customer_avatar%2F9CB04EFD-1B1E-4DA7-8D27-7511B9BC2C49?alt=media&token=ba430d22-49a9-40ef-936d-1e11b50e78ad]
            }
        })
    }
    
    func login( email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void ) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                let errorDetail = (error as! NSError).localizedDescription
                
                onError(errorDetail)
                
            }else{
                print("Login successfully!")
                
                guard let userId = FIRAuth.auth()?.currentUser?.uid else {
                    return
                }
                
                DataService.ds.REF_USERS.child(userId).observeSingleEvent(of: .value, with: {snapshot in
                    if let userData = snapshot.value as? Dictionary<String,Any>{
                        print(userData)
                        if let _ = userData["customer"]{
                            
                            onSuccess()
                        }
                        if let supplier = userData["supplier"]{
                            print(supplier)
                            
                            onError("Tài khoản của bạn là tài khoản nhà cung cấp, vui lòng sử dụng ứng dụng \(APP_NAME) Supplier")
   
                        }
                    }
                }
                )
                
                
                
                
            }
        })

    }
    
    
}