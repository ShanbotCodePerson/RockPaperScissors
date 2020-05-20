//
//  RPSGameViewController.swift
//  RockPaperScissors
//
//  Created by Leonardo Diaz on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class RPSGameViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var userHeart1: UIImageView!
    @IBOutlet weak var userHeart2: UIImageView!
    @IBOutlet weak var userHeart3: UIImageView!
    @IBOutlet weak var enemyHeart1: UIImageView!
    @IBOutlet weak var enemyHeart2: UIImageView!
    @IBOutlet weak var enemyHeart3: UIImageView!
    @IBOutlet weak var enemyNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var earthButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var enemyImageView: UIImageView!
    
    //MARK: - Properties
    var enemyHearts = 3
    var userHearts = 3
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func waterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func fireButtonTapped(_ sender: Any) {
        // If won
        presentRoundAlertController(title: "You Won!")
        // else if lost
        presentRoundAlertController(title: "You Lost!")
        // else tie
        presentRoundAlertController(title: "TIE!")
    }
    
    @IBAction func earthButtonTapped(_ sender: Any) {
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
    }
    
    func resetBoard(){
        waterButton.isHidden = false
        earthButton.isHidden = false
        fireButton.isHidden = false
    }
    
    func newGame(){
        var enemyHearts = 3
        var userHearts = 3
    }
    
    func presentRoundAlertController(title: String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (reset) in
            
        }
        alertController.addAction(continueAction)
        present(alertController, animated: true)
    }
    
    private func presentFinalAlertController(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let quitAction = UIAlertAction(title: "Quit", style: .destructive) { (quit) in
            
        }
        let restartAction = UIAlertAction(title: "Restart", style: .default) { (_) in
            self.newGame()
        }
        alertController.addAction(quitAction)
        alertController.addAction(restartAction)
        
        present(alertController, animated: true)
    }
}
