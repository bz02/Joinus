//
//  ViewController.swift
//  Joinus
//
//  Created by Xiaobo Zhang on 9/17/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var activityName: UITextField!
    
    @IBOutlet weak var activityLocation: UITextField!
    
    @IBOutlet weak var activityDescription: UITextView!
    
    @IBAction func submitActivity(_ sender: UIButton) {
        let urlPath: String = "http://joinus-env.us-east-2.elasticbeanstalk.com/activity/createActivity"
        let parameters: [String: Any] = [
            "title": activityName.text!,
            "location": activityLocation.text!,
            "descrition": activityDescription.text,
            "startTime": 123,
            "endTime": 124
        ]
        
        Alamofire.request(urlPath, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
        }
    }
    
    
    
    @IBAction func loadActivity(_ sender: UIButton) {
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com//activity/listAll"
        Alamofire.request(urlPath).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    
}

