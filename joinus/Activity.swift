//
//  Activity.swift
//  Joinus
//
//  Created by Xiaobo Zhang on 9/17/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import Foundation
import Alamofire

class Activity {
    private var curTitle = ""
    private var curLocation = ""
    private var curDescription = ""
    private var curStartTime = 0
    private var curEndTime = 0
    
    var title: String {
        get {
            return curTitle
        }
        set {
            curTitle = newValue
        }
    }
    
    var location: String {
        get {
            return curLocation
        }
        set {
            curLocation = newValue
        }
    }
    
    var descrition: String {
        get {
            return curDescription
        }
        set {
            curDescription = newValue
        }
    }
    
    var startTime: Int {
        get {
            return curStartTime
        }
        set {
            curStartTime = newValue
        }
    }
    
    var endTime: Int {
        get {
            return curEndTime
        }
        set {
            curEndTime = newValue
        }
    }
    
    func submitActivity() {
        let urlPath: String = "http://joinus-env.us-east-2.elasticbeanstalk.com/activity/createActivity"
        let parameters: [String: Any] = [
            "title": curTitle,
            "location": curLocation,
            "descrition": curDescription,
            "startTime": curStartTime,
            "endTime": curEndTime
        ]
        
        Alamofire.request(urlPath, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
        }
    }
    
    func getActivity() {
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
