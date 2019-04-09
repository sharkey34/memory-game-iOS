//
//  Card.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 12/20/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class Card: UIButton {
    
    var cardImage: UIImage?
    var backImage: UIImage?

    // Initializer to set up the card values
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        backImage = UIImage(named: "cardBack")
        
        self.setImage(backImage, for: .normal)
    }
}
