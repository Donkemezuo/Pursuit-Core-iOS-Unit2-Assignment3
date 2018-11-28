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
    
    private func startGame(){
        updateGameLabel(with: "Welcome🤝! Player 1 please enter a word")
        firstPlayerInput(input: invisibleWord)
        playerOneInputWord.text! = ""
        hangManImage.image = UIImage(named: "hang1")
    }
    private func firstPlayerInput(input:String){
        hiddenWordArray = Array(repeating: "-", count: invisibleWord.count)
        arrayFirstPlayerInputWord = invisibleWord.map{String($0)}
        let hiddenWord = hiddenWordArray.reduce("", +)
        updateGameLabel(with: hiddenWord)
    }
    private func updateGameLabel(with message: String){
        gameUpdate.text = message
    }
    
    private func isInputValid(wordInput: String) -> Bool {
        guard alphabet.contains(wordInput.lowercased()) else {
            updateGameLabel(with: "You can only input alphabets")
            return false }
        return true
    }
    
    private func isPlayerTwoInputValid(char: String) -> Bool {
      
        guard char.count == 1, alphabet.contains(char.lowercased()) else {
            updateGameLabel(with: "You can only input alphabets and one alphabet at a time")
            return false}
        return true
    }
    
    private func isSecondPlayerInputContainedInWord(input:String) -> Bool{
        
        if usedLetters.contains(input.lowercased()){
            return false
        }
        if !invisibleWord.contains(input.lowercased()) {
            usedLetters.append(input)
            numberOfTrials -= 1
            updateGameLabel(with: """
                Wrong input. You have \(numberOfTrials) trials left
                Please try again
                """)
            setHangManImage(trials: numberOfTrials)
            if numberOfTrials == 0{
                playerLost()
            }
            return false
            
        }
        return true
    }
 
    
    private func findAndReplaceSecondPlayerInput(input: String) -> String {
        for (index, character) in invisibleWord.enumerated(){
            if input == String(character) {
                hiddenWordArray[index] = String(character)
            }
        }
        return hiddenWordArray.reduce("", +)
    }
    
    
    private func playerLost(){
playerTwoInputChar.isEnabled = false
updateGameLabel(with: "You are dead. The right word is \(invisibleWord)")
        
    }
    
    private func winningCondition(string: String) -> Bool {
        let winningWord = hiddenWordArray.reduce("", +)
        if winningWord == invisibleWord {
            updateGameLabel(with: "Ye You won. \(invisibleWord) is the right word")
        }
        return true
    }
    
    private func setHangManImage(trials: Int){
        switch numberOfTrials{
            
        case 6:
            hangManImage.image = UIImage.init(named: "hang1")
        case 5:
            hangManImage.image = UIImage.init(named: "hang2")
        case 4:
            hangManImage.image = UIImage.init(named: "hang3")
        case 3:
            hangManImage.image = UIImage.init(named: "hang4")
        case 2:
            hangManImage.image = UIImage.init(named: "hang5")
        case 1:
            hangManImage.image = UIImage.init(named: "hang6")
        case 0:
            hangManImage.image = UIImage.init(named: "hang7")
        default:
            "You dead bro. Give Up"
        }
    }
    @IBAction func gameRestartButton(_ sender: UIButton) {
        startGame()
        playerOneInputWord.isEnabled = true
        playerTwoInputChar.isEnabled = true

    }
    
    
    
}

extension TwoPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == playerOneInputWord {
            if let firstPlayerInputWord = playerOneInputWord.text {
                invisibleWord = firstPlayerInputWord
                firstPlayerInput(input: invisibleWord)
            }
        }



        return  true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == playerTwoInputChar {
            guard isInputValid(wordInput: string) else {return false}
            guard isPlayerTwoInputValid(char: string) else {return false}
            guard isSecondPlayerInputContainedInWord(input: string) else {return false}
            let newString = findAndReplaceSecondPlayerInput(input: string)
            updateGameLabel(with: newString)
            guard winningCondition(string: string) else {return false}

        }

        return true
    }
}



