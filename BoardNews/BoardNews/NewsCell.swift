//
//  NewsCell.swift
//  BoardNews
//
//  Created by Serina Chen on 5/13/20.
//  Copyright © 2020 Serina Chen. All rights reserved.
//

import UIKit
class NewsCell: UITableViewCell{
    
    static let reuseIdentifier = "NewsCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
