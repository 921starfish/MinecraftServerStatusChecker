//
//  MyTableViewCell.swift
//  MSSC
//
//  Created by 王一道 on 2016/02/06.
//  Copyright © 2016年 王一道. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewController:UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    private var subVC: InputTextViewController?
    
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
