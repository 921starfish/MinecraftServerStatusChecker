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
    
    override func viewDidAppear(animated: Bool) {
        DataManager.instance.updateStatus()
        self.tableView.reloadData()
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
        return DataManager.instance.length
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ServerTableCell
        
        cell.name?.text = DataManager.instance[indexPath.row].server.name
        if(DataManager.instance[indexPath.row].status.players.online == nil){
            cell.online?.enabled = false
        }
        else{
            cell.online?.enabled = true
            let online = DataManager.instance[indexPath.row].status.players.online
            let max = DataManager.instance[indexPath.row].status.players.max
            cell.name?.text = (cell.name?.text)! +  (NSString(format: " (%d/%d)",online,max) as String)
        }
        cell.icon?.text = cell.name?.text?.substringToIndex((cell.name?.text?.startIndex.advancedBy(1))!)
        return cell
    }
    
    private var subVC: EditServerViewController?
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEditServerViewController",sender: nil)
        subVC?.setServer(indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toEditServerViewController") {
            subVC = (segue.destinationViewController as? EditServerViewController)!
        }
    }
}
