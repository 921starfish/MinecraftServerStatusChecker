//
//  EditServerViewController.swift
//  MSSC
//
//  Created by wang on 2016/02/08.
//  Copyright © 2016年 王一道. All rights reserved.
//

import UIKit

class EditServerViewController: UITableViewController {
    
    @IBOutlet var nameCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var hostCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var portCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var onlineCell: PropatyTableViewCell? = PropatyTableViewCell()
    @IBOutlet var descriptionCell: PropatyTableViewCell? = PropatyTableViewCell()
    
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
}
