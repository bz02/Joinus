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
        cell.locationLabel.text = activities[indexPath.row].descrition
        cell.timeLabel.text = String(activities[indexPath.row].startTime)
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
    
    @IBAction func userLogout(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedin")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    
    func downloadActivity() {
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/activity/getActivity"
        Alamofire.request(urlPath).responseJSON { response in
            if let activeArray = response.result.value as? NSArray {
                for active in activeArray {
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
                        self.activities.append(activity)
                        OperationQueue.main.addOperation( {
                            self.tableView.reloadData()
                        })
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
