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
    @IBOutlet weak var logInPlayButton: RPSRoundedButton!
    
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
    
    func createUser(){
        let alertController = UIAlertController(title: "Create an Account", message: nil, preferredStyle: .actionSheet)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a cool warrior name here!"
        }
        let confirm = UIAlertAction(title: "Sign Up", style: .default) { (signup) in
            guard let userName = alertController.textFields?.first?.text, !userName.isEmpty else { print("Can't be a nameless warrior"); return }
            UserController.shared.createNewUser(with: userName) { (result) in
                if !result {
                    print("Error creating a new user")
                }
            }
        }
        alertController.addAction(confirm)
        present(alertController, animated: true)
    }
    
} //End
