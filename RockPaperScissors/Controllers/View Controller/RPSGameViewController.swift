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
    @IBOutlet weak var outcomeLabel: UILabel!
    
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
    
    
    @IBAction func fireTouchDown(_ sender: UIButton) {
        fireButton.backgroundColor?.withAlphaComponent(0.6)
    }
    
    @IBAction func fireButtonTapped(_ sender: Any) {
        presentResult(elementValue: 0)
        fireButton.isHidden = true
        waterButton.isEnabled = false
        earthButton.isEnabled = false
        fireButton.backgroundColor = .systemOrange
    }
    
    @IBAction func waterTouchDown(_ sender: UIButton) {
        waterButton.backgroundColor = .black
    }
    
    @IBAction func waterButtonTapped(_ sender: Any) {
        presentResult(elementValue: 1)
        waterButton.isHidden = true
        fireButton.isEnabled = false
        earthButton.isEnabled = false
        waterButton.backgroundColor = .systemBlue
    }
    
    @IBAction func earthTouchDown(_ sender: UIButton) {
        earthButton.backgroundColor = .purple
    }
    
    @IBAction func earthButtonTapped(_ sender: Any) {
        presentResult(elementValue: 2)
        earthButton.isHidden = true
        fireButton.isEnabled = false
        waterButton.isEnabled = false
        earthButton.backgroundColor = .systemGreen
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
                presentFinalAlertController(title: "YOU ARE THE WINNER", message: "How about another? \n Score: \(userHearts)")
            } else {
                outcomeLabel.text = "WINNER"
                dispatchTimer()
            }
        case .lose:
            userHearts -= 1
            userHeartsArray[userHearts].image = UIImage(systemName: "heart")
            if userHearts == 0 {
                presentFinalAlertController(title: "YOU ARE THE LOSER", message: "Want to play again loser? \n Score: \(userHearts)")
            } else {
                outcomeLabel.text = "YOU SUCK"
                dispatchTimer()
            }
        case .tie:
            outcomeLabel.text = "TIS A TIE"
            dispatchTimer()
        }
    }
    
    private func resetBoard(){
        outcomeLabel.text = "BATTLE!"
        waterButton.isHidden = false
        earthButton.isHidden = false
        fireButton.isHidden = false
        waterButton.isEnabled = true
        earthButton.isEnabled = true
        fireButton.isEnabled = true
        userImageView.backgroundColor = .systemPurple
        enemyImageView.backgroundColor = .systemPurple
        self.userImageView.image =  #imageLiteral(resourceName: "questionMark")
        self.enemyImageView.image = #imageLiteral(resourceName: "questionMark")
    }
    
    private func dispatchTimer(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.resetBoard()
        }
    }
    
    private func newGame(){
        enemyHearts = 3
        userHearts = 3
        resetBoard()
        userHeartsArray.forEach { $0.image = UIImage(systemName: "heart.fill") }
        enemyHeartsArray.forEach { $0.image = UIImage(systemName: "heart.fill") }
    }
    
    private func presentFinalAlertController(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        UserController.shared.updateScore(by: userHearts) { (result) in
            if !result{ print("Error updating user Score")}
        }
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
