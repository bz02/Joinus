//
//  UserFolloweeTableViewCell.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/5/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class UserFolloweeTableViewCell: UITableViewCell {

    @IBOutlet weak var followeeImageLabel: UIImageView!
    
    @IBOutlet weak var followeeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
