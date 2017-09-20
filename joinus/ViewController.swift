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
    
    @IBOutlet weak var startTimeField: UITextField!

    @IBOutlet weak var endTimeField: UITextField!
    
    @IBAction func startTimeEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func endTimeEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.endDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func submitActivity(_ sender: UIButton) {
        let activity = Activity()
        activity.title = activityName.text!
        activity.location = activityLocation.text!
        activity.descrition = activityDescription.text!
        let dateFormatter = DateFormatter()
        let startDate: Date = dateFormatter.date(from:startTimeField.text!)!
        activity.startTime = Int((startDate.timeIntervalSince1970))
        let endDate: Date = dateFormatter.date(from:endTimeField.text!)!
        activity.endTime = Int((endDate.timeIntervalSince1970))
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

