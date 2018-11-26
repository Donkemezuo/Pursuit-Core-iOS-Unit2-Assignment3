//
//  SinglePlayerViewController.swift
//  Hangman
//
//  Created by Donkemezuo Raymond Tariladou on 11/23/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class SinglePlayerViewController: UIViewController {
    @IBOutlet weak var gameUpdate: UILabel!
    @IBOutlet weak var randomWordDisplay: UITextField!
    @IBOutlet weak var characterInput: UITextField!
    @IBOutlet weak var hangManImage: UIImageView!
    var numberOfTrials = 6
    var allAvailableWord = allTheWords
     var playerTwoChar = "a"
    var arrayRandomWord = [String]()
    var usedOfLetters: [String] = []
    
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var randomWord = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterInput.delegate = self
        if let random = allAvailableWord.randomElement() {
            randomWordDisplay.text = random
        }
        for character in randomWord{
            arrayRandomWord.append(String(character))
        }
    }
    
    func mySinglePlayer(char: String) {
        if let myChar = characterInput.text {
            guard myChar.count == 1 else {return gameUpdate.text = "Only One Character at a time"}
             playerTwoChar = myChar
            guard alphabet.contains(playerTwoChar) else {return gameUpdate.text = "You can only input alphabets"}
        }
    }
    
    func singleGameBrain(word:String) {
        var UserGuessWord = Array(repeatElement("-", count: arrayRandomWord.count))
        gameUpdate.text = "\(UserGuessWord)"
        while numberOfTrials > 0 {
            gameUpdate.text = """
            You have \(numberOfTrials) left
            Enter letter
"""
            if !arrayRandomWord.contains(playerTwoChar) {
                usedOfLetters.append(playerTwoChar)
                gameUpdate.text = "Wrong guess. Please try again"
                numberOfTrials -= 1
            } else {
                for i in 0...arrayRandomWord.count-1 {
                    if arrayRandomWord[i] == playerTwoChar {
                        UserGuessWord[i] = playerTwoChar
                        if UserGuessWord == arrayRandomWord {
                            gameUpdate.text = "Ye!!! YOU WON🕺 \(arrayRandomWord) is the right word"
                        }
                    }
                }
            }
        }
if numberOfTrials == 0 {
gameUpdate.text = "YOU LOST 💀 ! The right word was \(randomWord)"
        }
        
        switch numberOfTrials {
        case 6:
            hangManImage.image = UIImage.init(named:"hang1")
            
        case 5:
            hangManImage.image = UIImage.init(named:"hang2")
            
        case 4:
            hangManImage.image = UIImage.init(named:"hang3")
        case 3:
            hangManImage.image = UIImage.init(named:"hang4")
            
        case 2:
            hangManImage.image = UIImage.init(named:"hang5")
            
        case 1:
            hangManImage.image = UIImage.init(named:"hang6")
            
        case 0:
            hangManImage.image = UIImage.init(named:"hang7")
                default:
            "No pix"
        }
    }
}







extension SinglePlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        mySinglePlayer(char: playerTwoChar)
        singleGameBrain(word:randomWord)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
