//
//  UserFollweeViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/5/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class UserFolloweeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let followeeUsers = ["user1", "user2", "user3"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (followeeUsers.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFolloweeCell", for: indexPath) as! UserFolloweeTableViewCell
        cell.followeeNameLabel.text = self.followeeUsers[indexPath.row]
        
        cell.followeeImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
}
