//
//  ServerTableViewController.swift
//  MSSC
//
//  Created by wang on 2016/02/06.
//  Copyright © 2016年 wang. All rights reserved.
//

import UIKit

class ServerTableViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.data.serverArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ServerTableCell
        
        cell.name?.text = DataManager.instance.data.serverArray[indexPath.row].name
        
        return cell
    }

}
