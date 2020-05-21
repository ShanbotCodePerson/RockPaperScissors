//
//  RPSWelcomeViewController.swift
//  RockPaperScissors
//
//  Created by Leonardo Diaz on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class RPSWelcomeViewController: UIViewController {
    
    // MARK: - Outlets from storyboard

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logInPlayButton: RPSRoundedButton!
    
   // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextStroke()
        
        // Try to get the current user
        UserController.shared.fetchCurrentUser { [weak self] (success) in
            if success {
                // Change the text of the login button to play
                DispatchQueue.main.async { self?.logInPlayButton.setTitle("Play", for: .normal) }
            }
        }
    }
    
    // MARK: - Actions and Methods
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if UserController.shared.currentUser == nil {
            createUser()
            
        }
    }
    
    func setUpTextStroke() {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowBlurRadius = 5
        let string = NSAttributedString(string: "Battle of the Elements II", attributes: [
            NSAttributedString.Key.font : UIFont(name: "Copperplate-Bold", size: 71.0)!,
            NSAttributedString.Key.foregroundColor : UIColor.systemPurple,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.strokeWidth : -3
            //NSAttributedString.Key.shadow :shadow
            ])
        titleLabel.attributedText = string
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toGameVC" {
            // Make sure the user has an account, or else don't let them play the game
            guard UserController.shared.currentUser != nil else { return false }
        }
        return true
    }

    func createUser(){
        let alertController = UIAlertController(title: "Create an Account", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a cool warrior name here!"
        }
        let confirm = UIAlertAction(title: "Sign Up", style: .default) { (signup) in
            guard let userName = alertController.textFields?.first?.text, !userName.isEmpty else { print("Can't be a nameless warrior"); return }
            UserController.shared.createNewUser(with: userName) { [weak self] (success) in
                if success {
                    // Change the text of the login button to play
                    DispatchQueue.main.async { self?.logInPlayButton.setTitle("Play", for: .normal) }
                }
                else {
                    print("Error creating a new user")
                }
            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(confirm)
        present(alertController, animated: true)
    }
    
} //End
