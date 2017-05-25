//
//  PopupPhotoCell.swift
//  Elite Condos
//
//  Created by Hoang on 3/17/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
/**
 We follow MVC model.
 This class is subclass of UICollectionViewCell
 This class is for Image Cell that is used collection of PopupPhotoVC
 - Author: Khoa Nguyen
 
 */
class PopupPhotoCell: UICollectionViewCell {
    
    /**
     Description image
     - Author: Hoang
     
     */
    @IBOutlet weak var photo: UIImageView!
    
    /**
     Initialization code
     - Author: Hoang
     
     */
       override func awakeFromNib() {
        
    }
    /**
     Set image
     - Author: Hoang
     
     */
    func configureCell(img: UIImage){
        photo.image = img
    }
}
