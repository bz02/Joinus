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

    var titleArr = [String]()
    var locationArr = [String]()
    var timeArr = [String]()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleArr.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActiveTableViewCell
        cell.titleLabel.text = titleArr[indexPath.row]
        cell.locationLabel.text = locationArr[indexPath.row]
//        cell.timeLabel.text = timeArr[indexPath.row]
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "showActivityDetail", sender: titleArr[indexPath.row])
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let guest = segue.destination as! ActivityDetailViewController
//        guest.micky = sender as! String
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            
//        }
//    }
    
    
    @IBAction func userLogout(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedin")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    
    func downloadActivity() {
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/activity/getActivity"
        Alamofire.request(urlPath).responseJSON { response in
            if let activeArray = response.result.value as? NSArray {
                print("activeArray: \(activeArray)")
                for active in activeArray {
                    if let activeDict = active as? NSDictionary {
                        if let name = activeDict.value(forKey: "title") {
                            print(name)
                            self.titleArr.append(name as! String)
                        }
                        if let name = activeDict.value(forKey: "description") {
                            self.locationArr.append(name as! String)
                        }
//                        if let name = activeDict.value(forKey: "startTime") {
//                            let num = name as! Int
//                            self.timeArr.append("\(num)")
//                        }
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
        print("-----------test84")
        print("\(isUserLoggedin)", isUserLoggedin)
        if (!isUserLoggedin) {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
}
