//
//  ViewController.swift
//  FlipCard
//
//  Created by Joshua on 2018/3/5.
//  Copyright © 2018年 Joshua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)

    var numberOfPairOfCards: Int {
        return cardButtons.count/2
    }
    
    private var flipCounts: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips : \(flipCounts)"
        }
    }
    
    @IBOutlet private var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func shuffleTheCards(_ sender: UIButton) {
        game.startOver()
        flipCounts = 0
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCounts += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card wasn't in cardButtons!")
        }
    }
    
    private func updateViewFromModel() {
         for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.598092258, blue: 0.3952965736, alpha: 0) : #colorLiteral(red: 1, green: 0.598092258, blue: 0.3952965736, alpha: 1)
            }
         }
    }
    
    private var emojiChoices = ["👻","🎃","👾","🤖","💩","💀","🙀","👽"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }

}

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

extension Array {
    public mutating func shuffleUseSort() -> Array {
        var list = self
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
}
