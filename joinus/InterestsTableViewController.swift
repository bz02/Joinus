//
//  InterestsTableViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/5/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class InterestsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let interests = ["狼人杀", "扑克", "篮球"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (interests.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath) as! InterestTableViewCell
        cell.interestNameLabel.text = self.interests[indexPath.row]
        
        cell.interestImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
}
