//
//  UserFollweeViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/5/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class UserFolloweeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myIndex = 0
    @IBOutlet weak var followeeTableView: UITableView!
    
    var followeeUsers = [User]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (followeeUsers.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFolloweeCell", for: indexPath) as! UserFolloweeTableViewCell
        cell.followeeNameLabel.text = self.followeeUsers[indexPath.row].userName
        
        cell.followeeImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadFollowees()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myIndex = indexPath.row
    }
    
    func followUser() {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/follow"
        let parameters = [
            "id": self.followeeUsers[self.myIndex].id
        ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value {

            }
            self.followeeUsers = [User]()
            print("testxiaobozhangUser 51 userfollowing")
            self.downloadFollowees()
        }
    }
    
    func cancelFollow() {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/unfollow"
        let parameters = [
            "id": self.followeeUsers[self.myIndex].id
        ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("testxiaobozhangUser51: \(json)") // serialized json response
            }
            self.followeeUsers = [User]()
            print("testxiaobozhangUser 51 userfollowing")
            self.downloadFollowees()
        }
    }
    
    func downloadFollowees() {
        let parameters = [
            "id": 1,
            ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/user/getFollowers"
        Alamofire.request(urlPath, parameters: parameters).responseJSON { response in
            if let objDict = response.result.value as? NSDictionary {
                if let json = response.result.value {
                    print("testxiaobozhangUserIds: \(json)") // serialized json response
                }
                if let userIdsArray = objDict["ids"] as? NSArray {
//                    let temp = [1, 2, 3]
//                    let parametersForUserInfo = [
//                        "ids": temp
//                        ]
                    
                    let urlPathForUserInfo = "http://joinus-env.us-east-2.elasticbeanstalk.com/user/userBatchGet?ids=1,2,3"
                    Alamofire.request(urlPathForUserInfo).responseJSON { response in
                        if let json2 = response.result.value {
                            print("testxiaobozhangFollowees: \(json2)") // serialized json response
                        }
                        if let objUsersDict = response.result.value as? NSDictionary {
                            if let userArray = objUsersDict["objs"] as? NSArray {
                                for user in userArray {
                                    if let userDict = user as? NSDictionary {
                                        let user = User()
                                        if let id = userDict.value(forKey: "id") {
                                            user.id = id as!Int
                                        }
                                        if let name = userDict.value(forKey: "name") {
                                            user.userName = name as! String
                                        }
                                        self.followeeUsers.append(user)
                                        OperationQueue.main.addOperation( {
                                            self.followeeTableView.reloadData()
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}
