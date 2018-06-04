//
//  ViewController.swift
//  ApplePie
//
//  Created by Oleksandr Filippov on 27.05.2018.
//  Copyright © 2018 OleksandrFilippov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["food", "names", "hobbies", "animal", "houshold"]
    let incorrectMoveAllowed = 7
    var totalWins = 0{
        didSet{
            updateUI()
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            updateUI()
            newRound()
        }
    }
    
    var currentGame: Game!
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMoveAllowed, guessedLetters:[])
            updateUI()
             //enableLetterButtons(false)
        }else{
            enableLetterButtons(false)
        }
        
    }
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
            treeImageView.image = UIImage(named: "apple\(currentGame.incorrectMovesRemaining)")
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        //sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }else{
            updateUI()
        }
    }
    func enableLetterButtons(_ enable:Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }

}

