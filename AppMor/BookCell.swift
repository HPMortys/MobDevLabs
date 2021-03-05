//
//  BookCell.swift
//  AppMor
//
//  Created by Den Mor on 03.03.2021.
//

import UIKit

class BookCell: UITableViewCell {
 
    @IBOutlet var imageV: UIImageView!
 
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subtitleLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
