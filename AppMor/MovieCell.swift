//
//  MovieCell.swift
//  AppMor
//
//  Created by Den Mor on 03.03.2021.
//

import UIKit

class MovieCell: UITableViewCell {
 
    @IBOutlet var posterV: UIImageView!
 
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var yearLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
