//
//  Concentration.swift
//  Concentration
//
//  Created by Joshua on 2018/3/7.
//  Copyright © 2018年 Joshua. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = Array<Card>()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index) : chosen index not in the cards.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards) : you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        calculateRunTimeCost {
            cards = cards.shuffleUseSort()
        }
    }
    
    func startOver() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        calculateRunTimeCost {
            cards = cards.shuffleUseSort()
        }
    }
    
    private func calculateRunTimeCost(withMethod method: () -> Void ) {
        let startTime = CFAbsoluteTimeGetCurrent()
        method()
        let endTime = CFAbsoluteTimeGetCurrent()
        debugPrint("Cost Time : \((endTime - startTime)*1000)")
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
