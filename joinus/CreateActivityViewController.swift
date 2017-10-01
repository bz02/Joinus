//
//  ViewController.swift
//  Joinus
//
//  Created by Xiaobo Zhang on 9/17/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class CreateActivityViewController: UIViewController {
    
    @IBOutlet weak var activityName: UITextField!
    @IBOutlet weak var activityLocation: UITextField!
    @IBOutlet weak var activityDescription: UITextView!
    @IBOutlet weak var activitySummary: UITextView!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var endTimeField: UITextField!

    @IBAction func startTimeEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CreateActivityViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func endTimeEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CreateActivityViewController.endDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func submitActivity(_ sender: UIButton) {
        let activity = Activity()
        activity.title = activityName.text!
        activity.location = activityLocation.text!
        activity.descrition = activityDescription.text!
        activity.summary = activitySummary.text!
        activity.submitActivity()
    }
    
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        startTimeField.text = dateFormatter.string(from: sender.date)
        
    }
    
    @objc func endDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        endTimeField.text = dateFormatter.string(from: sender.date)
        
    }
}

