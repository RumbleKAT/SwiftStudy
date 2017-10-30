//
//  TableCellTableViewCell.swift
//  Homework
//
//  Created by 송명진 on 2017. 10. 30..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellimage: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
