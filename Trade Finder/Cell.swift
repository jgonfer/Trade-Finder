//
//  Cell.swift
//  Trade Finder
//
//  Created by Josep González on 16/2/16.
//  Copyright © 2016 Josep Gonzalez Fernandez. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func setupCellAvatar(avatar: UIImage) {
        self.avatar.image = avatar
        layoutSubviews()
    }
}