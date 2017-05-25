//
//  ServiceListCell.swift
//  Elite Condos
//
//  Created by Khoa on 11/18/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit


/**
 We follow MVC model.
 This class is subclass of UICollectionViewCell
 This class is for Detail Image Cell that is used collection of OrderDetailVC
 - Author: Khoa Nguyen
 
 */

class ServiceListCell: UITableViewCell {
    /**
     Price label
     - Author: Khoa Nguyen
     
     */
    @IBOutlet weak var priceLbl: UILabel!
    
    /**
     Name of the item label
     - Author: Khoa Nguyen
     
     */
    
    @IBOutlet weak var nameLbl: UILabel!
    
    /**
     Initialization code
     - Author: Khoa Nguyen
     
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /**
     Set price for cell
     - Author: Khoa Nguyen
     
     */
    func configureCell(service : Service){
        //priceLbl.text = service.price
        nameLbl.text  = service.name
    }

}
