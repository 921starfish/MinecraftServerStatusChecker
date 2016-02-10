//
//  PropatyTableViewCell.swift
//  MSSC
//
//  Created by wang on 2016/02/06.
//  Copyright © 2016年 wang. All rights reserved.
//

import UIKit

class PropatyTableViewCell: UITableViewCell {

    @IBOutlet internal var propaty:UITextField?
    @IBOutlet internal var value:UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
