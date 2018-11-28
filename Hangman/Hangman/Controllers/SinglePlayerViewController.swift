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
    @IBOutlet weak var characterInput: UITextField!
    @IBOutlet weak var hangManImage: UIImageView!
    var numberOfTrials = 6
    var allAvailableWord = allTheWords
    var playerChar = "a"
    var arrayRandomWord = [String]()
    var usedLetters: [String] = []
    var hiddenStringArray = [String]()
    
    var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var randomWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterInput.delegate = self
        startGame()
        
    }

    
    private  func startGame(){
        setRandomWord()
        hangManImage.image = UIImage(named: "hang1")
        characterInput.text = ""
    }
    
    private func setRandomWord(){
        if let random = allAvailableWord.randomElement() {
            randomWord = random
            hiddenStringArray = Array(repeatElement("-", count: randomWord.count))
            arrayRandomWord = random.map {String($0)}
            
            let hiddenString = hiddenStringArray.reduce("", +)
            updateGameLabel(with: hiddenString)
        }
    }
    private func updateGameLabel(with message: String){
        gameUpdate.text = message
    }
    
    private func isInputValid(input: String) -> Bool{
        guard alphabet.contains(input.lowercased()) else {
            updateGameLabel(with: "You can only input characters")
            return false}
        guard input.count == 1 else {
            updateGameLabel(with: "You can only input one character at a time")
            return false}
        return true
    }
    
    private func isInputContained(input: String) -> Bool{
        if usedLetters.contains(input.lowercased()){
            return false
        }
        
        if !randomWord.contains(input.lowercased()){
           usedLetters.append(input)
            numberOfTrials -= 1
            updateGameLabel(with: """
                Wrong input. You have \(numberOfTrials) trials left
                Please try again
                """)
           
            setHangManImage(trials: numberOfTrials)
            if numberOfTrials == 0 {
               playerLost()
            }
        }
       
        
        return randomWord.contains(input.lowercased())
    }
    
    func playerLost(){
        characterInput.isEnabled = false
        updateGameLabel(with: "You are dead💀! The right word is \(randomWord)")
        
    }
  
    private func findAndReplaceUserInputCharacter(input: String) -> String {
        for (index, character) in randomWord.enumerated() {
            if input == String(character) {
                hiddenStringArray[index] = String(character)
         
            }
        }
        return hiddenStringArray.reduce("", +)
    }
    
    private func winning(string:String) -> Bool {
        let winningWord = hiddenStringArray.reduce("",+)
        if winningWord == randomWord {
            updateGameLabel(with: "Yeah You Won. \(randomWord) is the right word")
        }
        return true
    }
    
    private func setHangManImage(trials: Int){
        switch numberOfTrials {
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
    

    
}





extension SinglePlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard isInputValid(input: string) else { return false }
        guard isInputContained(input: string) else { return false}
        
        let newString = findAndReplaceUserInputCharacter(input: string)
        updateGameLabel(with: newString)
        guard winning(string: string) else {return false}
       
        return true
    }
}
