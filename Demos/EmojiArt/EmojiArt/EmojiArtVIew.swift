//
//  EmojiArtVIew.swift
//  EmojiArt
//
//  Created by Joshua on 2018/3/14.
//  Copyright © 2018年 Joshua. All rights reserved.
//

import UIKit

class EmojiArtVIew: UIView {

    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
