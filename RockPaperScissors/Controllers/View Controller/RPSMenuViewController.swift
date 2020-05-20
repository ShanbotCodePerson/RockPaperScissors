//
//  RPSMenuViewController.swift
//  RockPaperScissors
//
//  Created by Leonardo Diaz on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class RPSMenuViewController: UIViewController {
    
    //MARK: - Actions
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        // Reset the game and return to that views
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mainMenuButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
