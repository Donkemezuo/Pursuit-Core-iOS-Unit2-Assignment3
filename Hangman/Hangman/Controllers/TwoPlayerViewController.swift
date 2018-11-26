//
//  TwoPlayerViewController.swift
//  Hangman
//
//  Created by Donkemezuo Raymond Tariladou on 11/23/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class TwoPlayerViewController: UIViewController {
    @IBOutlet weak var playerOneInputWord: UITextField!
    @IBOutlet weak var gameNotification: UILabel!
    @IBOutlet weak var playerTwoInputChar: UITextField!
    @IBOutlet weak var restartGame: UIButton!
    @IBOutlet weak var hangManImage: UIImageView!
    
    var numberOfTrials = 6
    var invisibleWord = ""
    var playerTwoChar:Character = "a"
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var usedLetters:[Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneInputWord.delegate = self
        playerTwoInputChar.delegate = self
             
    }
    
    func gameBrain(string:String, char: Character) {
        
        if let word = playerOneInputWord.text {
            invisibleWord = String(word)
            if let myChar = playerTwoInputChar.text {
                if myChar.count == 1 {
                playerTwoChar = Character(myChar)
                    guard invisibleWord.contains(playerTwoChar) else {return}
                 gameNotification.text = "\(playerTwoChar)"

        }
        }
    }
        
    }
    func myGameUpdate(str: String){
        while numberOfTrials > 0 {
        var gameBoard:[Character] = Array(repeating: "-", count: invisibleWord.count)
        var playerWordInArray = Array(invisibleWord)
        gameNotification.text = String(gameBoard)
 
        if !invisibleWord.contains(playerTwoChar) {
        usedLetters.append(playerTwoChar)
            numberOfTrials -= 1
            gameNotification.text = "Wrong guess. \(numberOfTrials) lives life"
        } else {
        for i in 0...playerWordInArray.count - 1 {
            if playerWordInArray[i] == playerTwoChar {
                gameBoard[i] = playerTwoChar
                if gameBoard == playerWordInArray {
                    gameNotification.text = "Ye!!! YOU WON🕺 \(invisibleWord) is the right word"
}
}
}
}
}
    }
}

extension TwoPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        gameBrain(string: invisibleWord, char:playerTwoChar )
        myGameUpdate(str: invisibleWord)
        return  true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}



