//
//  UserApi.swift
//  Elite Condos
//
//  Created by Hien on 3/21/17.
//  Copyright © 2017 Hien. All rights reserved.
//

import Foundation
import Firebase


/**
 All the network code related to user.
 - Author: Khoa Nguyen
 
 */

class UserApi{

    /**
     Get current user's id. We use the API from Firebase Auth to return a user, then return its uid
     
     - Author: Khoa Nguyen
     
     */
    func currentUid() -> String{
        
        let currentUser = FIRAuth.auth()?.currentUser
        return (currentUser?.uid)!
        
    }
    
    /**
    Update token from FCM to database for sending notifications.
    - Parameter token: The token is received from FCM
    - Parameter onSuccess: The function executes after updating token to database
     
     - Author: Khoa Nguyen
 
    */
    func updateTokenToDatabase(token: String, onSuccess: @escaping () -> Void){
        if let user = FIRAuth.auth()?.currentUser {
            FirRef.CUSTOMERS.child(user.uid).updateChildValues(["token": token])
            onSuccess()
        }
    }
    
    
    
    /**
     Update user's location including latitude and longitude to database.
     - Parameter lat: latitude
     - Parameter long: longitude
     - Parameter onSuccess: The function executes after updating user's location to database
     
     - Author: Khoa Nguyen
     
     */
    
    func updateUserLocation(lat: Double, long: Double, onSuccess: @escaping () -> Void){
        
    
        
        FirRef.USERS.child(currentUid()).child("locations").updateChildValues(["lat": lat, "long": long])
        
        onSuccess()
    }
    
    
    /**
     Get user's location including latitude and longitude from database.
     - Parameter onSuccess: The function executes after downloading user's location to database
     
     - Author: Khoa Nguyen
     
     */
    
    func getLocation(onSuccess: @escaping (Double, Double) -> Void){
        let currentId = Api.User.currentUid()
            FirRef.USERS.child(currentId).child("locations").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:Double] {
                
                print("dict of user: \(dict)")
                
                if let lat = dict["lat"], let long = dict["long"] {
                    onSuccess(lat,long)
                }
            }
        })
    }
    
    /**
     Update user's avatar to Firebase Storage then get the image url and update it to database
     - Returns: Image Url
     
     - Parameter avatarImg: The image.
     - Parameter onSuccess: The function executes after uploading user's image. We get the url from this parameter.
     - Parameter onError: The function executes after we can't uploading images. We get the error string from this parameter.
     
     - Author: Hoang Phan
     
     */

    
    func uploadAvatar(avatarImg: UIImage,onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void ){
        
        if let imgData = UIImageJPEGRepresentation(avatarImg, 0.2){
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            
            
            FirRef.CUSTOMER_AVATAR.child(imgUid).put(imgData, metadata: metadata, completion: { (metaData, error) in
                if error != nil{
                    onError(error.debugDescription)
                }else{
                    let downloadURL = metaData!.downloadURL()!.absoluteString
                    onSuccess(downloadURL)
                }
            })
        }
    }

    
    
    /**
     Get the url of the user's image.
     - Note: We already know user's ID from `Api.User.currentUid()`, so we don't need user's ID
     - Parameter onSuccess: The function executes after downloading user's image. We get the url from this parameter.
     
     - Author: Hoang Phan
     
     */
    
    func getImageProfileUrl(onSuccess: @escaping (String) -> Void){
        let currentId = Api.User.currentUid()
        FirRef.CUSTOMERS.child(currentId).observeSingleEvent(of: .  value, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String:Any]{
                if let imgUrl = dict["avatarUrl"] as? String{
                    onSuccess(imgUrl)
                }
            }
        })
    }
    
    
    /**
     Download user's image.
     - Note: We already know user's ID from `Api.User.currentUid()`, so we don't need user's ID
     - Warning: This function is different with `getImageProfileUrl`. It returns ***UIImage***
     - Parameter onSuccess: The function executes after downloading user's image. We get the url from this parameter.
     - Parameter onError: The function executes after we can't downloading images
     
     - Author: Hoang Phan
     
     */
    
    func downloadUserImage(onError: @escaping (String) -> Void, onSuccess: @escaping (UIImage) -> Void){
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        FirRef.CUSTOMERS.child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snap = snapshot.value as? [String:Any]{
                if let imgUrl = snap["avatarUrl"] as? String{
                    self.downloadImage(imgUrl: imgUrl, onError: { (error) in
                        onError(error)
                    }, onSuccess: { (img) in
                        onSuccess(img)
                    })
                }
            }
        })
    }
    
    /**
     Download image from a url.
  
     - Parameter imgUrl: The image url.
     - Parameter onSuccess: The function executes after downloading user's image. We get the UIImage from this parameter.
     - Parameter onError: The function executes after we can't downloading images. We get the error string from this parameter.
     
     - Author: Hoang Phan
     
     */
    
    func downloadImage(imgUrl: String, onError: @escaping (String) -> Void, onSuccess: @escaping (UIImage) -> Void ){
        let storage = FIRStorage.storage()
        let ref = storage.reference(forURL: imgUrl)
        ref.data(withMaxSize: 3 * 1024 * 1024) { (data, error) in
            if let error = error {
                onError(error.localizedDescription)
            }else{
                let img = UIImage(data: data!)
                onSuccess(img!)
            }
        }
    }
    
    /**
     Forget password. We send password reset to user.
     
     - Parameter email: The email address of user.
     - Parameter onError: The function executes after reseting email fail
     - Parameter onSuccess: The function executes after reseting email successfully
     
     - Author: Hoang Phan
     
     */
    
    func forgetPassword(email: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void ){
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error != nil {
                onError((error?.localizedDescription)!)
                return
            }
            onSuccess()
        })
    }
    
    /**
     Update phone number
     
     - Parameter phone: phone number.
     - Parameter onSuccess: The function executes after updating phone successfully
     
     - Author: Hoang Phan
     
     */
    
    
    func updatePhone(phone: String, onSuccess: @escaping () -> Void) {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        FirRef.CUSTOMERS.child(user.uid).updateChildValues(["phone": phone])
        
        onSuccess()
    }
    
    /**
     Update name
     
     - Parameter phone: User's full name
     - Parameter onSuccess: The function executes after updating user's name
     - Author: Hoang Phan
     
     */
    
    func updateName(name: String, onSuccess: @escaping () -> Void) {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        FirRef.CUSTOMERS.child(user.uid).updateChildValues(["name": name])
        
        onSuccess()
    }
    
    
    /**
     Update email
     
     - Parameter email: Email address
     - Parameter onSuccess: The function executes after updating email successfully
     - Parameter onError: The function executes after updating email fail
     - Author: Hoang Phan
     
     */
    
    func updateEmail(email: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void){
        
        
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        
        
        
        FIRAuth.auth()?.currentUser?.updateEmail(email, completion: { (callback) in
            if callback != nil {
                onError((callback?.localizedDescription)!)
                return
            }else {
                FirRef.CUSTOMERS.child(user.uid).updateChildValues(["email": email])
                onSuccess()
            }
            
        })
        
    }
    
    /**
     Update password
     
     - Parameter password: The new password
     - Parameter onSuccess: The function executes after updating password successfully
     - Parameter onError: The function executes after updating password fail
     - Author: Hoang Phan
     
     */
    
    func updatePassword(password: String, onError: @escaping (String) -> Void){
        
        FIRAuth.auth()?.currentUser?.updatePassword(password, completion: { (error) in
            if error != nil {
                onError((error?.localizedDescription)!)
            }
        })
    }
    
    
    /**
     Update avatar
     
     - Parameter password: The new avatar
     - Parameter onSuccess: The function executes after updating avatar successfully
     - Parameter onError: The function executes after updating avatar fail
     - Author: Hoang Phan
     
     */
    
    func updateAvatar(image: UIImage,onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void ){
        
        uploadAvatar(avatarImg: image, onSuccess: { (imageUrl) in
            FirRef.CUSTOMERS.child(Api.User.currentUid()).updateChildValues(["avatarUrl": imageUrl])
            
        }, onError: onError)
        
        
    }
    
    
    /**
     Load user's data. This function is called in AccountVC ( The profile screen  ).
     - Note: We get a ***Tuple*** `(name,email,phone)`
     
     - Parameter completed: The function executes after signing out successfully. We get the a ***Tuple*** `(name,email,phone)` here
     - Author: Hoang Phan
     
     */
    
   
    func loadUserData(completed: @escaping (String,String,String) -> Void){
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        FirRef.CUSTOMERS.child(user.uid).observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:Any]{
                guard let phone = dict["phone"] as? String else{
                    return
                }
                guard let name = dict["name"] as? String else{
                    return
                }
                
                
                let email = FIRAuth.auth()?.currentUser?.email
                
                if let email = email{
                    completed(name, email, phone)
                }
                
            }
        })
    }

    
    
    
    /**
     Sign out
     
     - Parameter onSuccess: The function executes after signing out successfully
     - Parameter onError: The function executes after signing out fail
     - Author: Hoang Phan
     
     */
    
    func signOut(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void){
        do {
            try  FIRAuth.auth()?.signOut()
            onSuccess()
        } catch{
            onError("can't sign out")
        }
    }
    
    /**
     Sign up.
     
     - Parameter name: User's name
     - Parameter email: User's email
     - Parameter password: User's password
     - Parameter phone: User's phone
     - Parameter avatarImg: User's avatarImg
     - Parameter onSuccess: The function executes after signing up successfully
     - Parameter onError: The function executes after signing up fail
     - Author: Hoang Phan
     
     */
    
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
                    
                    self.createFirebaseDBCutomer(uid: user.uid, userData: userData)
                    onSuccess()
                }
            })
            
        }) { (error) in
            onError(error)
        }
        
    }
    
    /**
    Sign in.
     
     - Parameter email: User's email
     - Parameter password: User's password
     - Parameter onSuccess: The function executes after signing in successfully
     - Parameter onError: The function executes after signing in fail
     - Author: Hoang Phan
     
     */
    
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
                
                FirRef.USERS.child(userId).observeSingleEvent(of: .value, with: {snapshot in
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
    
    /**
     This function executes right after a user creates his account.
     
     - Parameter uid: User's uid
     - Parameter userData: A ***Dictionary** has: user's name, email, phone, address.
     - Author: Khoa Nguyen
     
     */
    
    
    func createFirebaseDBCutomer(uid : String, userData : Dictionary<String, String>  ){
        
        FirRef.CUSTOMERS.child(uid).updateChildValues(userData)
        
        
        
        let currentTime = getCurrentTime()
        FirRef.USERS.child(uid).updateChildValues(["customer" : true,
                                                   "created_at" : currentTime])
    }
    
    
    
}
