//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var singlePlayerOption: UIButton!
    @IBOutlet weak var twoPlayerOption: UIButton!
    //    var allmyWord = allTheWords
    var invisibleWordToGuess = allTheWords.randomElement()
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    // Do any additional setup after loading the view, typically from a nib.
  }
   
}

