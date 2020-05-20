//
//  GamePlay.swift
//  RockPaperScissors
//
//  Created by Shannon Draeker on 5/20/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import Foundation

class GamePlay {
    
    // MARK: - Singleton
    
    static let shared = GamePlay()
    
    // MARK: - Game Outcomes
    
    enum Outcome {
        case win
        case lose
        case tie
    }
    
    // MARK: - Game Methods
    
    // Calculate who won the round
    func getOutcome(of userMove: Int, vs computerMove: Int) -> Outcome {
        // 0 - "rock", 1 - "paper", 2 - "scissors"
        
        // Compare the user's move to the computer's move
        let difference = userMove - computerMove
        
        // Calculate the result
        if difference == 0 { return .tie }
        return difference == 1 || difference == -2 ? .win : .lose
    }
    
    // Generate a random move for the computer's choice
    func generateComputerMove() -> Int {
        return Int.random(in: 0...2)
    }
}
