//
//  myContentsCell.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class myContentsCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
