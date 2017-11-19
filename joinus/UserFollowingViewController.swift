//
//  UserFollowingViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 10/29/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class UserFollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myIndex = 0
    
    @IBOutlet weak var followerTableView: UITableView!
    var followingUsers = [User]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (followingUsers.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFollowingCell", for: indexPath) as! UserFollowingTableViewCell
        cell.userNameLabel.text = self.followingUsers[indexPath.row].userName
        
        cell.userImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        downloadFollowers();
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myIndex = indexPath.row
    }
    
    @IBAction func cancelFollow(_ sender: UIButton) {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/unfollow"
        let parameters = [
            "id": self.followingUsers[self.myIndex].id
            ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("testxiaobozhangUser51: \(json)") // serialized json response
            }
            self.followingUsers = [User]()
            print("testxiaobozhangUser 51 userfollowing")
            self.downloadFollowers()
        }
    }
    
    func downloadFollowers() {
        let parameters = [
            "id": 1,
            ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/user/getFollowed"
        Alamofire.request(urlPath, parameters: parameters).responseJSON { response in
            if let objDict = response.result.value as? NSDictionary {
                if let json = response.result.value {
                    print("testxiaobozhangUserIds1: \(json)") // serialized json response
                }
                if let userIdsArray = objDict["ids"] as? NSArray {
                    var urlPathForUserInfo = "http://joinus-env.us-east-2.elasticbeanstalk.com/user/userBatchGet"
                    var str = ""
                    for id in userIdsArray {
                        str = str + "," + String(describing: id)
                    }
                    if (str.characters.count > 0) {
                        urlPathForUserInfo = urlPathForUserInfo + "?id=" + str
                    }
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
                                        self.followingUsers.append(user)
                                        OperationQueue.main.addOperation( {
                                            self.followerTableView.reloadData()
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
