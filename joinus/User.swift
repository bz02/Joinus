//
//  User.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/26/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import Foundation
import Alamofire

class User {
    private var curId = 0
    private var curAge = 0
    private var curUserName = ""
    private var curEmail = ""
    private var curPassword = ""
    private var curSelfIntro = ""
    private var curGender = "Male"
    
    var email: String {
        get {
            return curEmail
        }
        set {
            curEmail = newValue
        }
    }
    
    var selfIntro: String {
        get {
            return curSelfIntro
        }
        set {
            curSelfIntro = newValue
        }
    }
    
    var gender: String {
        get {
            return curGender
        }
        set {
            curGender = newValue
        }
    }
    
    var userName: String {
        get {
            return curUserName
        }
        set {
            curUserName = newValue
        }
    }
    
    var password: String {
        get {
            return curPassword
        }
        set {
            curPassword = newValue
        }
    }
    
    var age: Int {
        get {
            return curAge
        }
        set {
            curAge = newValue
        }
    }
    
    var id: Int {
        get {
            return curId
        }
        set {
            curId = newValue
        }
    }
    
    func getFollowedUserIds() -> NSSet {
        let idSet = NSSet();
        var urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/user/getFollowed"
        urlPath = urlPath + "?id=" + UserDefaults.standard.string(forKey:"UserId")!
        Alamofire.request(urlPath).responseJSON { response in
            if let objDict = response.result.value as? NSDictionary {
                if let json = response.result.value {
                    print("testxiaobozhangUserIds1: \(json)") // serialized json response
                }
                if let userIdsArray = objDict["ids"] as? NSArray {
                    for id in userIdsArray {
                        idSet.adding(id);
                    }
                }
            }
        }
        return idSet
    }
            
    func getUsersByIds(ids : NSSet) -> NSSet {
        var urlPathForUserInfo = "http://joinus-env.us-east-2.elasticbeanstalk.com/user/userBatchGet"
        var str = ""
        let set = NSSet();
        for id in ids {
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
                            set.adding(user);
                        }
                    }
                }
            }
        }
        
        return set
    }
    
    func followUser(id : Int) -> Bool {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/follow"
        let parameters = [
            "id": id
        ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("testxiaobozhangUser51: \(json)") // serialized json response
            }
        }
        
        return true
    }
    
    func cancelFollow(id : Int) -> Bool {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/unfollow"
        let parameters = [
            "id": id
        ]
        Alamofire.request(urlPath, parameters: parameters, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("testxiaobozhangUser51: \(json)") // serialized json response
            }
            
        }
        
        return true
    }
    
}
