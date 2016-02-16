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
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var years: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewFriends: UITableView!
    
    let reuseIdentifier = "cell"
    var gnome: Gnome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    func setupController() {
        guard let gnome = gnome else {
            navigationController?.popToRootViewControllerAnimated(false)
            return
        }
        
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
        tableViewFriends.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
        
        name.text = gnome.name
        weight.text = String(format: "%.2f", gnome.weight)
        height.text = String(format: "%.2f", gnome.height)
        years.text = "\(gnome.age) years"
        
        ImageHelper.sharedInstance.imageForUrl(gnome.thumbnail, completionHandler:{(image: UIImage?, url: String) in
            if let image = image {
                self.avatar.image = image
                self.avatar.layer.masksToBounds = true
                self.avatar.layer.cornerRadius = self.avatar.frame.width/2
            }
        })
    }
}

extension ViewControllerDetail: UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView.tag == 0 ? "Professions" : "Friends"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let gnome = gnome else {
            return 1
        }
        switch tableView.tag {
        case 0:
            guard let profs = gnome.professions else {
                return 1
            }
            return profs.count
        case 1:
            guard let friends = gnome.friends else {
                return 1
            }
            return friends.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        let tag = tableView.tag
        
        guard let gnome = gnome else {
            cell?.textLabel?.text = tag == 0 ? "Unemployed :(" : "Need a hug..."
            return cell!
        }
        
        switch tag {
        case 0:
            guard let professions = gnome.professions else {
                cell?.textLabel?.text = "Unemployed :("
                return cell!
            }
            
            cell?.textLabel?.text = professions[indexPath.row]
        case 1:
            guard let friends = gnome.friends else {
                cell?.textLabel?.text = "Need a hug..."
                return cell!
            }
            
            cell?.textLabel?.text = friends[indexPath.row]
        default:
            return cell!
        }
        
        cell?.selectionStyle = .None
        
        return cell!
    }
}