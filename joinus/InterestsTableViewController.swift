//
//  InterestsTableViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/5/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire



class InterestsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myIndex = 0
    
    @IBOutlet weak var interestTableView: UITableView!
    var interests = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (interests.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath) as! InterestTableViewCell
        cell.interestNameLabel.text = self.interests[indexPath.row]
        
        cell.interestImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myIndex = indexPath.row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        downloadInterests()
    }
    
    func downloadInterests() {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/getUser"
        Alamofire.request(urlPath, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("InterestJSON: \(json)") // serialized json response
            }
            if let objDict = response.result.value as? NSDictionary {
                if let user = objDict["obj"] as? NSDictionary {
                    if let interestArray = user["interestedActivityType"] as? NSArray {
                        for interest in interestArray {
                            self.interests.append(interest as! String)
                        }
                        OperationQueue.main.addOperation( {
                            self.interestTableView.reloadData()
                        })
                    }
                }
            }
        }
    }
    
    func unfollowInterest() {
        
    }
}
