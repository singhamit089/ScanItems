//
//  CartTableViewCell.swift
//  ScanItems
//
//  Created by Amit Singh on 07/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelItem: UILabel!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // iOS 13 bug
        
        self.labelItem.textColor = .black
        self.labelQty.textColor = .black
        self.labelPrice.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
