//
//  OnlineTableViewController.swift
//  MSSC
//
//  Created by wang on 2016/02/10.
//  Copyright © 2016年 王一道. All rights reserved.
//

import UIKit

class OnlineTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "引っ張って更新")
        self.refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
    }
    func refresh()
    {
        // 更新するコード(webView.reload()など)
        DataManager.instance.updateCurrentStatus()
        self.tableView.reloadData()
        refreshControl!.endRefreshing()
    }
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let i = DataManager.instance.current.status.players.sample.count
        return i
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PlayersCell
        
        cell.name.text = DataManager.instance.current.status.players.sample[indexPath.row].name
        cell.id.text = DataManager.instance.current.status.players.sample[indexPath.row].id
        return cell
    }
}
