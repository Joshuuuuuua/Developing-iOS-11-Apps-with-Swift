//
//  ViewController.swift
//  PlayingCard
//
//  Created by Joshua on 2018/3/8.
//  Copyright © 2018年 Joshua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
        
    }
    
}

