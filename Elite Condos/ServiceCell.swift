//
//  ServiceCell.swift
//  Elite Condos
//
//  Created by Khoa on 3/15/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit


/**
 We follow MVC model. 
 This class is subclass of UITableViewCell
 This class is for Service Cell that is used tableview of HomeVC and SubCategoryVC
 - Author: Khoa Nguyen
 
 */

class ServiceCell: UITableViewCell {

    
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
       
    }
    
    /**
     Set name and image for controls.
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
