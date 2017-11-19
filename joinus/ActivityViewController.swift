//
//  ActivityViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/20/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

var myIndex = 0

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var activities = [Activity]()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (activities.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActiveTableViewCell
        cell.titleLabel.text = activities[indexPath.row].title
        cell.descriptionLabel.text = activities[indexPath.row].descrition
        cell.timeLabel.text = String(activities[indexPath.row].startTime)
        cell.locationLabel.text = activities[indexPath.row].location
//        let url = URL(string: "https://static.pexels.com/photos/20787/pexels-photo.jpg")
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if (error != nil) {
//                print("Error")
//            } else {
//                var documentsDirectory:String?
//                var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//                if paths.count > 0 {
//                    documentsDirectory = paths[0]
//                    let savePath = documentsDirectory! + "/pexels-photo.jpg"
//                    FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
//                    DispatchQueue.main.async {
//                        cell.profileImageView.image = UIImage(named: savePath)
//                    }
//                }
//            }
//
//        }
//        task.resume()
        cell.profileImageView.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "showActivityDetail", sender: activities[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivityDetail" {
            let guest = segue.destination as! ActivityDetailViewController
            guest.activity = sender as! Activity
        }
    }
    
    @IBAction func joinActivity(_ sender: UIButton) {
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/activity/joinActivity"
        let parameters: [String: Any] = [
            "id": self.activities[myIndex].id,
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
             print("Request: \(String(describing: response.request))")
        }
    }
    
    func downloadActivity() {
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/activity/getActivity"
        Alamofire.request(urlPath).responseJSON { response in
            if let objDict = response.result.value as? NSDictionary {
                if let activiArray = objDict["objs"] as? NSArray {
                    for active in activiArray {
                        if let activeDict = active as? NSDictionary {
                            let activity = Activity()
                            if let id = activeDict.value(forKey: "id") {
                                activity.id = id as!Int
                            }
                            if let userId = activeDict.value(forKey: "userId") {
                                activity.userId = userId as!Int
                            }
                            if let name = activeDict.value(forKey: "title") {
                                activity.title = name as! String
                            }
                            if let name = activeDict.value(forKey: "description") {
                                activity.descrition = name as! String
                            }
                            if let time = activeDict.value(forKey: "startTime") {
                                let num = time as! Int
                                activity.startTime = num
                            }
                            if let address = activeDict.value(forKey: "address") {
                                activity.location = address as! String
                            }
    //                        let participentURL = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/activity/joinActivity"
    //                        Alamofire.request(participentURL).responseJSON { response in
    //                        }
                            self.activities.append(activity)
                            OperationQueue.main.addOperation( {
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        downloadActivity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedin = UserDefaults.standard.bool(forKey: "isUserLoggedin")
        if (!isUserLoggedin) {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
}
