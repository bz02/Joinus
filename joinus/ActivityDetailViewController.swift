//
//  ActivityDetailViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/23/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var activityLocation: UILabel!
    @IBOutlet weak var activityHost: UIButton!
    @IBOutlet weak var activityTime: UILabel!
    @IBOutlet weak var activityDescription: UILabel!

    var activity = Activity()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityTitle.text = activity.title
        activityDescription.text = activity.descrition
        activityTime.text = String(activity.startTime)
        activityHost.setTitle(String(activity.userId), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func joinActivity(_ sender: UIButton) {
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/activity/joinActivity"
        let parameters: [String: Any] = [
                "id": self.activity.id,
            ]
        
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
        }
    }
}
