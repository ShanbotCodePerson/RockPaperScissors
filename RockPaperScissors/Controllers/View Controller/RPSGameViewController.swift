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
    var colors: [UIColor] = [.systemOrange, .systemBlue, .earthGreen]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    //MARK: - Actions
    
    @IBAction func fireTouchUp(_ sender: Any) {
        fireButton.backgroundColor = .systemOrange
    }
    
    @IBAction func fireTouchDown(_ sender: UIButton) {
        fireButton.backgroundColor = .white
    }
    
    @IBAction func fireButtonTapped(_ sender: Any) {
        presentResult(elementValue: 0)
        fireButton.isHidden = true
        waterButton.isEnabled = false
        earthButton.isEnabled = false
        fireButton.backgroundColor = .systemOrange
    }
    @IBAction func waterTouchUp(_ sender: Any) {
        waterButton.backgroundColor = .systemBlue
    }
    
    @IBAction func waterTouchDown(_ sender: UIButton) {
        waterButton.backgroundColor = .white
    }
    
    @IBAction func waterButtonTapped(_ sender: Any) {
        presentResult(elementValue: 1)
        waterButton.isHidden = true
        fireButton.isEnabled = false
        earthButton.isEnabled = false
        waterButton.backgroundColor = .systemBlue
    }
    
    @IBAction func earthTouchUp(_ sender: Any) {
        earthButton.backgroundColor = .systemGreen
    }
    @IBAction func earthTouchDown(_ sender: UIButton) {
        earthButton.backgroundColor = .white
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
        
        self.outcomeLabel.text = "3"
        let label = Array("...2...1...")
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.outcomeLabel.text?.append(label[index])
            index += 1
            if index == label.count { timer.invalidate() }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {

            self.enemyImageView.image = self.elements[randomPick]
            self.enemyImageView.backgroundColor = self.colors[randomPick]
            self.userImageView.image = self.elements[elementValue]
            self.userImageView.backgroundColor = self.colors[elementValue]
            
            switch result {
            case .win:
                self.enemyHearts -= 1
                self.enemyHeartsArray[self.enemyHearts].image = UIImage(systemName: "heart")
                if self.enemyHearts == 0 {
                    self.presentFinalAlertController(title: "YOU ARE THE WINNER", message: "How about another? \n Score: \(self.userHearts)")
                } else {
                    self.outcomeLabel.text = "WINNER"
                    self.dispatchTimer()
                }
            case .lose:
                self.userHearts -= 1
                self.userHeartsArray[self.userHearts].image = UIImage(systemName: "heart")
                if self.userHearts == 0 {
                    self.presentFinalAlertController(title: "YOU ARE THE LOSER", message: "Want to play again loser? \n Score: \(self.userHearts)")
                } else {
                    self.outcomeLabel.text = "YOU SUCK"
                    self.dispatchTimer()
                }
            case .tie:
                self.outcomeLabel.text = "TIS A TIE"
                self.dispatchTimer()
            }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.outcomeLabel.text = "Rematch!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
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
