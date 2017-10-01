//
//  UserActivityTableViewController
//  joinus
//
//  Created by Xiaobo Zhang on 9/29/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class UserActivityTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    func downloadActivity() {
        print("test 46 user")
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/activity/getActivity"
        Alamofire.request(urlPath).responseJSON { response in
            if let objDict = response.result.value as? NSDictionary {
                if let activiArray = objDict["objs"] as? NSArray {
                    for active in activiArray {
                        if let activeDict = active as? NSDictionary {
                            let activity = Activity()
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
                            self.activities.append(activity)
                            print("65 activity: \(self.activities.count)")
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
