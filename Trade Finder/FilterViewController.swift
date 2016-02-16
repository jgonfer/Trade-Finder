//
//  FilterViewController.swift
//  Trade Finder
//
//  Created by Josep Gonzalez Fernandez on 16/2/16.
//  Copyright © 2016 Josep Gonzalez Fernandez. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func professionSelected(profession: String)
}

class FilterViewController: UITableViewController {
    let reuseIdentifier = "cell"
    
    var delegate: FilterViewControllerDelegate?
    
    var professions: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    func setupController() {
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let professions = professions else {
            return 1
        }
        return professions.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        guard let professions = professions else {
            cell?.textLabel?.text = "No professions available."
            return cell!
        }
        
        cell?.backgroundColor = UIColor.whiteColor()
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        if indexPath.row == 0 {
            cell?.textLabel?.text = "All professions"
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.backgroundColor = UIColor.blueColor()
            return cell!
        }
        
        cell?.textLabel?.text = professions[indexPath.row - 1]
        cell?.accessoryType = .DisclosureIndicator
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.row > 0 else {
            delegate?.professionSelected("")
            navigationController?.popToRootViewControllerAnimated(true)
            return
        }
        delegate?.professionSelected(professions![indexPath.row-1])
        navigationController?.popToRootViewControllerAnimated(true)
    }
}