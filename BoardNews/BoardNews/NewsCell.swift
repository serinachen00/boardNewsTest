//
//  NewsCell.swift
//  BoardNews
//
//  Created by Serina Chen on 5/8/20.
//  Copyright © 2020 Serina Chen. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
