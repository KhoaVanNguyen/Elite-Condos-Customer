//
//  PopupPhotoPickerVC.swift
//  Elite Condos
//
//  Created by Khoa on 3/17/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class PopupPhotoPickerVC: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    var images: [UIImage] = []
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var subViewTapped = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        subView.layer.cornerRadius = 10
        subView.clipsToBounds = true
        
     
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
       
        if touches.first?.view != subView{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteAllBtnPressed(_ sender: Any) {
        self.images = []
        collectionView.reloadData()
    }
   
}


extension PopupPhotoPickerVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopupPhotoCell", for: indexPath) as! PopupPhotoCell
        
        
        if indexPath.row == images.count {
            let img = UIImage(named: "add.png")
            cell.configureCell(img: img!)
        }
        else {
            let img = images[indexPath.row]
            cell.configureCell(img: img)
        }
        
        return cell
        
    }
}

extension PopupPhotoPickerVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count {
            present(imagePicker, animated: true, completion: nil)
        }
    }
}
extension PopupPhotoPickerVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3 - 2
        print(size)
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
extension PopupPhotoPickerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.images.append(img)
            self.collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
