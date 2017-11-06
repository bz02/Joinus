//
//  UserFollowingViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 10/29/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class UserFollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let followingUsers = ["user1", "user2", "user3"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (followingUsers.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFollowingCell", for: indexPath) as! UserFollowingTableViewCell
        cell.userNameLabel.text = self.followingUsers[indexPath.row]
        
        cell.userImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
}
