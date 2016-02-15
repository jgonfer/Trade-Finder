//
//  ViewController.swift
//  Trade Finder
//
//  Created by Josep Gonzalez Fernandez on 14/2/16.
//  Copyright © 2016 Josep Gonzalez Fernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data = NSMutableData()
    var gnomes: [Gnome]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        downloadGnomes()
    }
    
    private func setupController() {
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadGnomes(){
        let url: NSURL = NSURL(string: kUrlInfo)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { () -> Void in
            do {
                if let city = try NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    if let json = city["Brastlewark"] as? Array<NSDictionary> {
                        //let jsonResult: Array<NSDictionary>?
                        //print(json)
                        for item: NSDictionary in json {
                            let id = item["id"] as! Int
                            let name = item["name"] as! String
                            let thumbnail = item["thumbnail"] as! String
                            let age = item["age"] as! Int
                            let weight = item["weight"] as! Double
                            let height = item["height"] as! Double
                            let hair_color = item["hair_color"] as! String
                            let professions = item["professions"] as? Array<String>
                            let friends = item["friends"] as? Array<String>
                            let gnome = Gnome(id: id, name: name, thumbnail: thumbnail, age: age, weight: weight, height: height, hair_color: hair_color, professions: professions, friends: friends)
                            
                            guard let _ = self.gnomes else {
                                self.gnomes = [gnome]
                                continue
                            }
                            self.gnomes?.append(gnome)
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let gnomes = gnomes else {
            return 1
        }
        return gnomes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        guard let gnomes = gnomes else {
            cell?.textLabel?.text = "Downloading data..."
            return cell!
        }
        
        cell?.textLabel?.text = gnomes[indexPath.row].name
        cell?.accessoryType = .DisclosureIndicator
        
        return cell!
    }
}