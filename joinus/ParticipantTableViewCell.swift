//
//  ParticipantTableViewCell.swift
//  joinus
//
//  Created by Xiaobo Zhang on 11/19/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var participantImageLabel: UIImageView!
    
    @IBOutlet weak var participantNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

