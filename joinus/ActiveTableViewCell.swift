//
//  ActiveTableViewCell.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/21/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class ActiveTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
