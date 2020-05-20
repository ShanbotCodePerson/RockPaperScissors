//
//  RPSButton.swift
//  RockPaperScissors
//
//  Created by Shannon Draeker on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class RPSCircularButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
    
    func setUpViews() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}

class RPSRoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
    
    func setUpViews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
