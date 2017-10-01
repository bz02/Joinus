//
//  UserEditViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/26/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController {

    var user = User()
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var genderLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var workLabel: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("username: \(user.userName)")
        profileImage.image = UIImage(named: "cat.png")
        nameLabel.text = user.userName
        genderLabel.text = user.gender
        ageLabel.text = String(user.age)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
