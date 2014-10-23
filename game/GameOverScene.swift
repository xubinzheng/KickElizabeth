//
//  GameOverScene.swift
//  game
//
//  Created by Xubin Zheng on 10/22/14.
//  Copyright (c) 2014 Xubin Zheng. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene:SKScene{
    override init(size:CGSize){
        super.init(size:size)
        
        var label = SKLabelNode()
        label.text="Game Over"
            label.position = CGPoint(x: size.width/2,y: size.height/2)
            addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}