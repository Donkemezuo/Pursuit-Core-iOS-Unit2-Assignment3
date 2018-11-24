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
    
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var usedLetters:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneInputWord.delegate = self
        playerTwoInputChar.delegate = self
        
        if let word = playerOneInputWord.text{
            invisibleWord = String(word)
            guard alphabet.contains(invisibleWord) else {return}
            print(word)
            
            let arrOfPlayerOne = Array(word)
            var wordInCharacter = [String]()
            for char in arrOfPlayerOne {
                wordInCharacter.append(String(char))
            }
            
    let invisibleCharacterInput = String(repeatElement("-", count: word.count))
             gameNotification.text = invisibleCharacterInput
           
        if let characterInput = playerTwoInputChar.text {
            guard characterInput.count == 1 else {return}
            guard alphabet.contains(characterInput) else {return}
            }
            
            for i in 0...word.count {
                if wordInCharacter[i] == characterInput{
                    gameNotification.text = "You got it write"
                }
            }
            }
        }
    
   
    
    
    func myIntake(input: Character) -> Bool {
        if invisibleWord.contains(input) {
        }
        return true
    }
    
    }
extension TwoPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       
        if textField.text?.count == 1 {
            print("User entered a letter")
        }
        
        return  true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text ?? "")
        return true
    }
}
