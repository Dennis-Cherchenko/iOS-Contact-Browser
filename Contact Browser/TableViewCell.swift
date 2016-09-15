//
//  TableViewCell.swift
//  Contact Browser
//
//  Created by Dennis Cherchenko on 9/15/16.
//  Copyright © 2016 Dennis Cherchenko. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var number: UILabel!
}
