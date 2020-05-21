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
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
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
        backgroundColor = .spaceGray
        setTitleColor(.white, for: .normal)
    }
}
