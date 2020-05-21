//
//  RPSMenuViewController.swift
//  RockPaperScissors
//
//  Created by Leonardo Diaz on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

// MARK: - Main menu protocol

protocol MenuViewControllerDelegate: class {
    func triggerNewGame()
    func returnToMainMenu()
}

class RPSMenuViewController: UIViewController {
    
    // MARK: - Properties

    weak var delegate: MenuViewControllerDelegate?
    
    //MARK: - Actions
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        // Reset the game's settings
        delegate?.triggerNewGame()
        
        // Return to the game view
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mainMenuButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate?.returnToMainMenu()
    }
}
