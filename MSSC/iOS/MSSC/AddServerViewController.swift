//
//  MyTableViewCell.swift
//  MSSC
//
//  Created by wang on 2016/02/06.
//  Copyright © 2016年 wang. All rights reserved.
//

import Foundation
import UIKit

class AddServerViewController:UITableViewController{
    
    private func getTableView()->UITableView{
      return view as! UITableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        for section in 0..<getTableView().numberOfSections {
            
            for row in 0..<getTableView().numberOfRowsInSection(section) {
                
                let indexPath = NSIndexPath(forRow: row, inSection: section)
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! PropatyTableViewCell
                if(cell.value?.text == ""){
                    DoneButton?.enabled = false
                    return
                }
            }
        }
        DoneButton?.enabled = true
    }
    private var subVC: InputTextViewController?
    
    @IBOutlet var DoneButton: UIBarButtonItem?
    @IBOutlet var CancelButton: UIBarButtonItem?
    
    @IBAction func onclickDoneButton(sender: UIBarButtonItem){
        var cell = getTableView().cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PropatyTableViewCell
        let host = cell.value?.text
        cell = getTableView().cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! PropatyTableViewCell
        let port = cell.value?.text
        DataManager.instance.add(MinecraftServer(name: "Minecraft Server",host: host!,port: port!))
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toInputTextViewController",sender: nil)
        subVC?.setPropaty(tableView, indexPath: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toInputTextViewController") {
            subVC = (segue.destinationViewController as? InputTextViewController)!
        }
    }
}
