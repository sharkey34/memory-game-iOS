//
//  ScoresTableViewCell.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 8/20/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
