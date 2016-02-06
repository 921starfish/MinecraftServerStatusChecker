//
//  InputTextViewController.swift
//  MSSC
//
//  Created by 王一道 on 2016/02/05.
//  Copyright © 2016年 王一道. All rights reserved.
//

import Foundation
import UIKit

class InputTextViewController: UITableViewController{

    @IBOutlet var inputTextField: UITextField?
    private var edittingPropaty:PropatyTableViewCell?
    private var value:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField?.text = value
        inputTextField?.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        edittingPropaty?.value?.text = inputTextField?.text
    }
    
    internal func setPropaty(tableView: UITableView,indexPath: NSIndexPath){
       edittingPropaty = tableView.cellForRowAtIndexPath(indexPath) as? PropatyTableViewCell
       title = edittingPropaty?.propaty!.text
       value = (edittingPropaty?.value?.text)!
    }
}