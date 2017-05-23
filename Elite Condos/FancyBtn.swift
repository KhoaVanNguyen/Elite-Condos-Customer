//
//  FancyBtn.swift
//  devslopes-social
//
//  Created by Jess Rascal on 24/07/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit


/**
 Custom UIButton with shadow, rounded corner
 - Author: Khoa Nguyen
 
 */

class FancyBtn: UIButton {
    
    
    /**
     Set up
     - Author: Khoa Nguyen
     
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: CGFloat(SHADOW_GRAY), green: CGFloat(SHADOW_GRAY), blue: CGFloat(SHADOW_GRAY), alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }

}
