//
//  TableViewCell.swift
//  Homework
//
//  Created by 송명진 on 2017. 11. 1..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var friend_Image: UIImageView!
    @IBOutlet weak var friend_Name: UILabel!
    @IBOutlet weak var friend_Email: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialize friend_name font 
        self.friend_Name?.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
