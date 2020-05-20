//
//  RPSWelcomeViewController.swift
//  RockPaperScissors
//
//  Created by Leonardo Diaz on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class RPSWelcomeViewController: UIViewController {
    
    // Todo: Outlets from storyboard

    @IBOutlet weak var titleLabel: UILabel!
    
    // Todo:
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextStroke()
    }
    
    // MARK: - Actions and Methods
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
    }
    
    func setUpTextStroke() {
        let string = NSAttributedString(string: "Battle of the Elements II", attributes: [
            NSAttributedString.Key.font : UIFont(name: "Copperplate-Bold", size: 71.0),
            NSAttributedString.Key.foregroundColor : UIColor.systemYellow,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.strokeWidth : -4,
            ])
        titleLabel.attributedText = string
    }
    
} //End
