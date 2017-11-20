//
//  UserBrowseProfileViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/19/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class UserBrowseProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = UIImage(named: "cat.png")
        backgroundImage.image = UIImage(named: "blue.png")
        getUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserBrowseView" {
            let guest = segue.destination as! UserEditViewController
            guest.user = self.user
        }
    }
    
    func getUser() {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey:"token")!,
            "Username": UserDefaults.standard.string(forKey:"Username")!,
            "Content-Type": "application/json"
        ]
        let urlPath = "http://joinus-env.us-east-2.elasticbeanstalk.com/secure/user/getUser"
        Alamofire.request(urlPath, headers: headers).responseJSON { response in
            if let objDict = response.result.value as? NSDictionary {
                if let userDict = objDict["obj"] as? NSDictionary {
                    print("userDict : \(userDict)")
                    if let id = userDict.value(forKey: "id") {
                        self.user.id = id as!Int
                    }
                    if let name = userDict.value(forKey: "nickName") {
                        self.user.userName = name as! String
                        self.nameLabel.text = self.user.userName
                    }
                    if let email = userDict.value(forKey: "email") {
                        self.user.email = email as! String
                    }
                    if let selfIntro = userDict.value(forKey: "selfIntro") {
                        self.user.selfIntro = selfIntro as! String
                    }
                }
            }
        }
    }
}

