//
//  RPSView.swift
//  RockPaperScissors
//
//  Created by Bethany Morris on 5/21/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class RPSRoundedView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
    
    func setUpViews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
