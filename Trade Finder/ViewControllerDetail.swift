//
//  ViewControllerDetail.swift
//  Trade Finder
//
//  Created by Josep González on 16/2/16.
//  Copyright © 2016 Josep Gonzalez Fernandez. All rights reserved.
//

import UIKit

class ViewControllerDetail: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var avatarImage: String?
    var nameString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    func setupController() {
        name.text = nameString
        
        guard let avatarImage = avatarImage else {
            return
        }
        
        ImageHelper.sharedInstance.imageForUrl(avatarImage, completionHandler:{(image: UIImage?, url: String) in
            if let image = image {
                self.avatar.image = image
            }
        })
    }
}