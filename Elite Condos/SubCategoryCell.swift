//
//  SubCategoryCell.swift
//  Elite Condos
//
//  Created by Khoa on 3/15/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
/**
 We follow MVC model.
 This class is subclass of UITableViewCell
 
 - Author: Khoa Nguyen
 
 */
class SubCategoryCell: UITableViewCell {

    
    /**
     Service's name
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var serviceName: UILabel!
    
    /**
     Service's image
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var serviceImage: UIImageView!
   
    /**
     A feature of Swift, when this variable has value, a function will executes immediately
     - Author: Khoa Nguyen
     
     */
    var service: ServiceData?{
        didSet{
            configureCell()
        }
    }
    /**
     Initialization code
     - Author: Khoa Nguyen
     
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /**
     Set service's name and images
     - Author: Khoa Nguyen
     
     */
    func configureCell(){
        if let name = service?.name{
            serviceName.text = name
            
        }
        if let img = service?.imgUrl{
            serviceImage.image = UIImage(named: img)
        }
        
    }

   
}
