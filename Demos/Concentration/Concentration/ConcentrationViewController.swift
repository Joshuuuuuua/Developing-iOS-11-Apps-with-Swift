//
//  ViewController.swift
//  Concentration
//
//  Created by Joshua on 2018/3/7.
//  Copyright © 2018年 Joshua. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    /* ViewController Life Cycle
    override var vclLoggingName: String {
        return "Game"
    }
    */
    
    // Theme
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    // init the game
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return visibleCardButtons.count/2
    }
    
    // MARK: - Flip Count Label
    
    private var flipCounts: Int = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.598092258, blue: 0.3952965736, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips : \(flipCounts)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    // MARK: - Card Buttons
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    @IBAction private func shuffleTheCards(_ sender: UIButton) {
        game.startOver()
        flipCounts = 0
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCounts += 1
        if let cardNumber = visibleCardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card wasn't in cardButtons!")
        }
    }
    
    // MARK: - UpdateView
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        guard visibleCardButtons != nil else { return }
        for index in visibleCardButtons.indices {
            let button = visibleCardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.598092258, blue: 0.3952965736, alpha: 0) : #colorLiteral(red: 1, green: 0.598092258, blue: 0.3952965736, alpha: 1)
            }
        }
    }
    
    // MARK: - Emoji
    
    // private var emojiChoices = ["👻","🎃","👾","🤖","💩","💀","🙀","👽"]
    private var emojiChoices = "👻🎃👾🤖💩💀🙀👽"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            // emoji[card] = String(emojiChoices.remove(at: emojiChoices.count.arc4random))
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}

// MARK: - extensions

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

