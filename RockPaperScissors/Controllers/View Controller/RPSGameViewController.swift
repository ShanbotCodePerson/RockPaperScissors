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
    
    let gameLogic = GamePlay.shared
    //MARK: - Properties
    var enemyHearts = 3
    var userHearts = 3
    var enemyElements = [ #imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "water"), #imageLiteral(resourceName: "earth")]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func fireButtonTapped(_ sender: Any) {
        presentResult(elementValue: 0)
    }
    
    @IBAction func waterButtonTapped(_ sender: Any) {
        presentResult(elementValue: 1)
    }
    
    @IBAction func earthButtonTapped(_ sender: Any) {
        presentResult(elementValue: 2)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
    }
    
    func presentResult(elementValue: Int){
        let randomPick = gameLogic.generateComputerMove()
        let result = gameLogic.getOutcome(of: elementValue, vs: randomPick)
        enemyImageView.image = enemyElements[randomPick]
        switch result {
        case .win:
            presentRoundAlertController(title: "You Won!")
        case .lose:
            presentRoundAlertController(title: "You Lost!")
        case .tie:
            presentRoundAlertController(title: "TIE!")
        }
    }
    
    func resetBoard(){
        waterButton.isHidden = false
        earthButton.isHidden = false
        fireButton.isHidden = false
    }
    
    func newGame(){
        enemyHearts = 3
        userHearts = 3
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
