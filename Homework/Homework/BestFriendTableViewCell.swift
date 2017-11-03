//
//  BestFriendTableViewCell.swift
//  Homework
//
//  Created by 송명진 on 2017. 11. 2..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class BestFriendTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var friend_name: UILabel!
    @IBOutlet weak var friend_Email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.friend_name?.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
