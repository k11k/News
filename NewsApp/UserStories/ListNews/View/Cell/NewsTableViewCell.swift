//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let cellID   = "NewsTableViewCell"
    static let nibName  = "NewsTableViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func setup(title: String, date: String) {
        self.title.text = title
        self.date.text = date
//        selectionStyle = .none
    }
}
