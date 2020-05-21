//
//  StyleGuide.swift
//  RockPaperScissors
//
//  Created by Bethany Morris on 5/21/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

struct FontNames {
    
}

extension UIColor {
    
    static let mainBlue = UIColor(named: "mainBlue")!
    static let lightBlue = UIColor(named: "lightBlue")!
    static let spaceGray = UIColor(named: "spaceGray")!
    static let earthGreen = UIColor(named: "earthGreen")!
}
