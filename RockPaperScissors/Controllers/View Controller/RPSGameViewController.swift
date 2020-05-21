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
    var userHeartsArray: [UIImageView] { [userHeart1, userHeart2, userHeart3] }
    @IBOutlet weak var enemyHeart1: UIImageView!
    @IBOutlet weak var enemyHeart2: UIImageView!
    @IBOutlet weak var enemyHeart3: UIImageView!
    var enemyHeartsArray: [UIImageView] { [enemyHeart1, enemyHeart2, enemyHeart3] }
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
    var colors: [UIColor] = [.systemOrange, .systemBlue, .systemGreen]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func presentResult(elementValue: Int){
        let randomPick = gameLogic.generateComputerMove()
        let result = gameLogic.getOutcome(of: elementValue, vs: randomPick)
        
        enemyImageView.image = elements[randomPick]
        enemyImageView.backgroundColor = colors[randomPick]
        userImageView.image = elements[elementValue]
        userImageView.backgroundColor = colors[elementValue]
        
        switch result {
        case .win:
            enemyHearts -= 1
            enemyHeartsArray[enemyHearts].image = UIImage(systemName: "heart")
            if enemyHearts == 0 {
                presentFinalAlertController(title: "YOU ARE THE WINNER", message: "How about another?")
            } else {
                presentRoundAlertController(title: "You Won!")
            }
            resetBoard()
        case .lose:
            userHearts -= 1
            userHeartsArray[userHearts].image = UIImage(systemName: "heart")
            if userHearts == 0 {
                presentFinalAlertController(title: "YOU ARE THE LOSER", message: "Want to play again loser?")
            } else {
                presentRoundAlertController(title: "You Lost!")
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
        // TODO: - can't change the background colors back here or else no color will appear at all - decide on desired behavior
//        userImageView.backgroundColor = .systemPurple
//        enemyImageView.backgroundColor = .systemPurple
        // TODO: - get different question mark icons to use
//        userImageView.image =  UIImage(systemName: "questionmark.circle")
//        enemyImageView.image = UIImage(systemName: "questionmark.circle")
    }
    
    func newGame(){
        enemyHearts = 3
        userHearts = 3
        resetBoard()
        userHeartsArray.forEach { $0.image = UIImage(systemName: "heart.fill") }
        enemyHeartsArray.forEach { $0.image = UIImage(systemName: "heart.fill") }
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
            self.navigationController?.popViewController(animated: true)
        }
        let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] (_) in
            self?.newGame()
        }
        alertController.addAction(quitAction)
        alertController.addAction(restartAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenuVC" {
            guard let destinationVC = segue.destination as? RPSMenuViewController else { return }
            destinationVC.delegate = self
        }
    }
}

// MARK: - MenuViewControllerDelegate

extension RPSGameViewController: MenuViewControllerDelegate {
    func triggerNewGame() {
        newGame()
    }
    
    func returnToMainMenu() {
        navigationController?.popViewController(animated: false)
    }
}
