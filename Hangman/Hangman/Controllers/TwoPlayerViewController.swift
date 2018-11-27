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
    @IBOutlet weak var gameUpdate: UILabel!
    @IBOutlet weak var playerTwoInputChar: UITextField!
    @IBOutlet weak var restartGame: UIButton!
    @IBOutlet weak var hangManImage: UIImageView!
    
    var numberOfTrials = 6
    var invisibleWord = ""
    var playerTwoChar:Character = "a"
     var arrayFirstPlayerInputWord = [String]()
    var hiddenWordArray = [String]()
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var usedLetters:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneInputWord.delegate = self
        playerTwoInputChar.delegate = self
        startGame()
        firstPlayerInput(input: invisibleWord)
    }
    // start game func
    // first user input
    // update labels
    
    private func startGame(){
        updateGameLabel(with: "Welcome🤝! Player 1 please enter a word")
        firstPlayerInput(input: invisibleWord)
    }
    private func firstPlayerInput(input:String){
        if let firstPlayerInputWord = playerOneInputWord.text {
            invisibleWord = firstPlayerInputWord
            hiddenWordArray = Array(repeating: "-", count: invisibleWord.count)
            arrayFirstPlayerInputWord = invisibleWord.map{String($0)}
            let hiddenWord = hiddenWordArray.reduce("", +)
            updateGameLabel(with: hiddenWord)
        }
    }
    private func updateGameLabel(with message: String){
        gameUpdate.text = message
    }
    
    // function that check the letter input

    private func isInputValid(wordInput: String) -> Bool {
        guard alphabet.contains(wordInput) else {
            updateGameLabel(with: "You can only input alphabets")
            return false }
        return true
        }

private func isPlayerTwoInputValid(char: String) -> Bool {
    guard alphabet.contains(char), char.count == 1 else {
        updateGameLabel(with: "You can only input alphabets and one alphabet at a time")
        return false}
    return true
    }

 // function that checks if a secondplayer input is contained in firstPlayer word
    
    private func isSecondPlayerInputContainedInWord(input:String) -> Bool{
        if !invisibleWord.contains(input) {
            usedLetters.append(input)
            numberOfTrials -= 1
            updateGameLabel(with: """
                Wrong input. You have \(numberOfTrials) trials left
                Please try again
                """)
        }
        return false
    }
    // find the location of the user input character in our first userInput
    // insert the user input character at that location
    
    private func findAndReplaceSecondPlayerInput(input: String) -> String {
        for (index, character) in invisibleWord.enumerated(){
            if input == String(character) {
                hiddenWordArray[index] = String(character)
            }
        }
        return hiddenWordArray.reduce("", +)
    }
    
    private func winningCondition(string: String) -> Bool {
        let winningWord = hiddenWordArray.reduce("", +)
        if winningWord == invisibleWord {
            updateGameLabel(with: "Ye You won. \(invisibleWord) is the right word")
        }
          return true
    }
  
    
    
//    func gameBrain(string:String, char: Character) {
//        if let word = playerOneInputWord.text {
//            invisibleWord = String(word)
//            if let myChar = playerTwoInputChar.text {
//                if myChar.count == 1 {
//                playerTwoChar = Character(myChar)
//                    guard invisibleWord.contains(playerTwoChar) else {return}
//                 gameUpdate.text = "\(playerTwoChar)"
//        }
//        }
//    }
//
//    }
//    func myGameUpdate(str: String){
//        while numberOfTrials > 0 {
//        var gameBoard:[Character] = Array(repeating: "-", count: invisibleWord.count)
//        var playerWordInArray = Array(invisibleWord)
//        gameUpdate.text = String(gameBoard)
//
//        if !invisibleWord.contains(playerTwoChar) {
//        usedLetters.append(playerTwoChar)
//            numberOfTrials -= 1
//            gameUpdate.text = "Wrong guess. \(numberOfTrials) lives life"
//        } else {
//        for i in 0...playerWordInArray.count - 1 {
//            if playerWordInArray[i] == playerTwoChar {    
//                gameBoard[i] = playerTwoChar
//                if gameBoard == playerWordInArray {
//                    gameUpdate.text = "Ye!!! YOU WON🕺 \(invisibleWord) is the right word"
//}
//}
//}
//}
//}
//    }
}

extension TwoPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
      
        return  true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard isInputValid(wordInput: invisibleWord) else {return false}
        guard isPlayerTwoInputValid(char: string) else {return false}
        guard isSecondPlayerInputContainedInWord(input: string) else {return false}
        let newString = findAndReplaceSecondPlayerInput(input: string)
        updateGameLabel(with: newString)
        guard winningCondition(string: string) else {return false}
        
        return true
    }
}



