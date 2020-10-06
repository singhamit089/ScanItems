//
//  CartFooterTableViewCell.swift
//  ScanItems
//
//  Created by Amit Singh on 07/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit

class CartFooterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelSubtotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelSubtotal.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
