//
//  DescriptionViewController.swift
//  MSSC
//
//  Created by wang on 2016/02/10.
//  Copyright © 2016年 王一道. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBOutlet var descriptionText: UITextView!
    override func viewDidLoad() {
        descriptionText.text = DataManager.instance.current.status.description
    }
}
