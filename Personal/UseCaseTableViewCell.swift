//
//  UseCaseTableViewCell.swift
//  Personal
//
//  Created by mac on 28/01/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit

class UseCaseTableViewCell: UITableViewCell {

    @IBOutlet weak var Arrow: UILabel!
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
