//
//  CommentCell.swift
//  iShots
//
//  Created by Tope Abayomi on 04/01/2015.
//  Copyright (c) 2015 App Design Vault. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet var profileImageView : UIImageView!
    @IBOutlet var dateImageView : UIImageView!

    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var postLabel : UILabel!
    @IBOutlet var dateLabel : UILabel!

    override func awakeFromNib() {
        
//        dateImageView.image = UIImage(named: "clock")
//        dateImageView.alpha = 0.20
        profileImageView.layer.cornerRadius = 15
        profileImageView.clipsToBounds = true
        
//        nameLabel.font = UIFont(name: Theme.fontName, size: 16)
        nameLabel.textColor = Theme.darkColor
        
//        postLabel?.font = UIFont(name: Theme.fontName, size: 12)
        postLabel?.textColor = Theme.lightColor
        
//        dateLabel.font = UIFont(name: Theme.fontName, size: 11)
        dateLabel.textColor = Theme.lightColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        postLabel.preferredMaxLayoutWidth = CGRectGetWidth(postLabel.frame)

    }
}