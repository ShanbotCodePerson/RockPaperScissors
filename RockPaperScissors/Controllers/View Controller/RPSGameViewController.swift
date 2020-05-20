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
    var elements = [ #imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "water"), #imageLiteral(resourceName: "earth")]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.image = #imageLiteral(resourceName: "fire")
        enemyImageView.image = UIImage(named: "air")
        newGame()
    }
    
    //MARK: - Actions
    
    @IBAction func fireButtonTapped(_ sender: Any) {
        presentResult(elementValue: 0)
        fireButton.isHidden = true
    }
    
    @IBAction func waterButtonTapped(_ sender: Any) {
        presentResult(elementValue: 1)
        waterButton.isHidden = true
    }
    
    @IBAction func earthButtonTapped(_ sender: Any) {
        presentResult(elementValue: 2)
        earthButton.isHidden = true
    }
    // TODO: Delete
//    @IBAction func menuButtonTapped(_ sender: Any) {
//    }
    
    func presentResult(elementValue: Int){
        let randomPick = gameLogic.generateComputerMove()
        let result = gameLogic.getOutcome(of: elementValue, vs: randomPick)
        enemyImageView.image = elements[randomPick]
        userImageView.image = elements[elementValue]
        switch result {
        case .win:
            presentRoundAlertController(title: "You Won!")
            enemyHearts -= 1
            var heartImages = [enemyHeart1.image, enemyHeart2.image, enemyHeart3.image]
            heartImages[enemyHearts] = UIImage(named: "heart")
            userHeart3.image = UIImage(named: "heart")
            if enemyHearts == 0{
                presentFinalAlertController(title: "YOU ARE THE WINNER", message: "How about another?")
            }
            resetBoard()
        case .lose:
            presentRoundAlertController(title: "You Lost!")
            userHearts -= 1
            var heartImages = [userHeart1.image, userHeart2.image, userHeart3.image]
            heartImages[userHearts] = UIImage(named: "heart")
            if userHearts == 0{
                presentFinalAlertController(title: "YOU ARE THE LOSER", message: "Want to play again loser?")
            }
            resetBoard()
        case .tie:
            presentRoundAlertController(title: "TIE!")
            resetBoard()
        }
    }
    
    func resetBoard(){
        waterButton.isHidden = false
        earthButton.isHidden = false
        fireButton.isHidden = false
        userImageView.image = UIImage(named: "questionmark.circle")
        enemyImageView.image = UIImage(named: "questionmark.circle")
    }
    
    func newGame(){
        enemyHearts = 3
        userHearts = 3
        resetBoard()
        let fullHearts = [enemyHeart1, enemyHeart2, enemyHeart3, userHeart1, userHeart2, userHeart3]
        fullHearts.forEach({$0?.image = UIImage(named: "heart.filled")})
    }
    
    func presentRoundAlertController(title: String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { [weak self] (_) in
            self?.resetBoard()
        }
        alertController.addAction(continueAction)
        present(alertController, animated: true)
    }
    
    private func presentFinalAlertController(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let quitAction = UIAlertAction(title: "Quit", style: .destructive) { (quit) in
            // TODO: Navigation controller pop off
            self.navigationController?.popViewController(animated: true)
        }
        let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] (_) in
            self?.newGame()
        }
        alertController.addAction(quitAction)
        alertController.addAction(restartAction)
        
        present(alertController, animated: true)
    }
}
