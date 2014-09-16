//
//  ViewController.swift
//  Lecture2
//
//  Created by Кирилл on 05.09.14.
//  Copyright (c) 2014 kirillsidorov. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UITableViewController, UITableViewDataSource {
    
    var items: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request(.GET, "http://weekly.master-up.net/api/v1/lecture/list/").responseJSON { (request, response, JSON, error) -> Void in
            //
            
            self.items = JSON as? NSArray
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("LectureRow", forIndexPath: indexPath) as UITableViewCell
        
        if let item = self.items {
            let newItem = item[indexPath.row] as NSDictionary
            
            if let name = newItem["name"] as? String {
                    cell.textLabel?.text = name
            }
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let count = self.items?.count {
            return count
        }
        
        return 0
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as DetailVC
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            detailVC.title = "Лекция \(indexPath.row + 1)"
        }
        
    }
    


}

