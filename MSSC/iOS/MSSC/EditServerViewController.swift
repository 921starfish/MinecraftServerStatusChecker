//
//  EditServerViewController.swift
//  MSSC
//
//  Created by wang on 2016/02/08.
//  Copyright © 2016年 wang. All rights reserved.
//

import UIKit

class EditServerViewController: UITableViewController {
    
    @IBOutlet var nameCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var hostCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var portCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var onlineCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var descriptionCell: PropatyTableViewCell? = PropatyTableViewCell()
    
    @IBAction func onClickTrashButton(sender: AnyObject){
        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "注意", message: "このサーバーの情報を消します。", preferredStyle: .Alert)
        
        // OKのアクションを作成する.
        let myOkAction = UIAlertAction(title: "はい", style: .Default) { action in
               self.remove(self.index!)     }
        let myCancelAction = UIAlertAction(title: "キャンセル", style: .Default) { action in
        }
        // OKのActionを追加する.
        myAlert.addAction(myOkAction)
        myAlert.addAction(myCancelAction)
        // UIAlertを発動する.
        presentViewController(myAlert, animated: true, completion: nil)
       
    }
    
    func remove(index: Int){
        DataManager.instance.remove(self.index!)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    private var index: Int?
    func setServer(index:Int){
        self.index = index
    }
    
    override func viewDidLoad() {
        nameCell?.value?.text = DataManager.instance[index!].server.name
        hostCell?.value?.text = DataManager.instance[index!].server.host
        portCell?.value?.text = DataManager.instance[index!].server.port
        onlineCell?.value?.text = String(DataManager.instance[index!].status.players.online)
        descriptionCell?.value?.text = DataManager.instance[index!].status.description
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        DataManager.instance[index!].server.name = (nameCell?.value?.text)!
        DataManager.instance[index!].server.host = (hostCell?.value?.text)!
        DataManager.instance[index!].server.port = (portCell?.value?.text)!
        DataManager.instance.save()
    }
    
    private var subVC: InputTextViewController?
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section < 2){
            performSegueWithIdentifier("toInputTextViewController",sender: nil)
            subVC?.setPropaty(tableView, indexPath: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toInputTextViewController") {
            subVC = (segue.destinationViewController as? InputTextViewController)!
        }
    }

}
