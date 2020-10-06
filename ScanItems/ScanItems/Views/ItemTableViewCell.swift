//
//  ItemTableViewCell.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell, LoadableFromNib {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemQtyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // solving UI color bug in iOS 13 by setting it up manually
        
        itemNameLabel.textColor = .black
        itemPriceLabel.textColor = .black
        itemQtyLabel.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItemCell(item: Item) {
        itemImageView.sd_setImage(with: URL(string: item.thumbnailUrl ?? "") , placeholderImage: UIImage(named: "barcode"), options: SDWebImageOptions(), context: nil)
        itemNameLabel.text = item.title
        itemPriceLabel.text = "$ \(item.price)"
    }
    
}
