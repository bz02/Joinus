//
//  ViewController.swift
//  Joinus
//
//  Created by Xiaobo Zhang on 9/17/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityName: UITextField!
    
    @IBOutlet weak var activityLocation: UITextField!
    
    @IBOutlet weak var activityDescription: UITextView!
    
    @IBAction func submitActivity(_ sender: UIButton) {
        let activity = Activity()
        activity.title = activityName.text!
        activity.location = activityLocation.text!
        activity.descrition = activityDescription.text!
        activity.submitActivity()
    }
    
    
}

