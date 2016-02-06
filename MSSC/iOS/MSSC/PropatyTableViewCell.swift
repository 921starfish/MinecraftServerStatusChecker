//
//  PropatyTableViewCell.swift
//  MSSC
//
//  Created by 王一道 on 2016/02/06.
//  Copyright © 2016年 王一道. All rights reserved.
//

import UIKit

class PropatyTableViewCell: UITableViewCell {

    @IBOutlet internal var propaty:UITextField?
    @IBOutlet internal var value:UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
