//
//  ActivityDetailViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/23/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var activityLocation: UILabel!
    @IBOutlet weak var activityTime: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    
    var micky = "title"
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTitle.text = micky
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
