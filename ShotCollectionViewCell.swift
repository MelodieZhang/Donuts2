//
//  CollectionViewCell.swift
//  003-Dribbble-Client
//
//  Created by Audrey Li on 3/15/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

class ShotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var likesCount: UILabel!
    
    override func awakeFromNib() {
        let bgView = UIView(frame: self.bounds)
        self.backgroundView = bgView
        self.backgroundView?.backgroundColor = UIColor.whiteColor()
        
        let selectedbgView = UIView(frame: self.bounds)
        self.selectedBackgroundView = selectedbgView
        self.selectedBackgroundView?.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.05)
    }
    
}
