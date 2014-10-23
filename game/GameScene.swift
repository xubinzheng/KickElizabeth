//
//  GameScene.swift
//  game
//
//  Created by Xubin Zheng on 10/22/14.
//  Copyright (c) 2014 Xubin Zheng. All rights reserved.
//

import SpriteKit

let MASK_EDGE:UInt32=0b1
let MASK_BALL:UInt32=0b10
let MASK_FLAG:UInt32 = 0b100

class GameScene: SKScene ,SKPhysicsContactDelegate {
    
    
    
    var startGameLabel:SKLabelNode!
    var gameStarted=false;
    var ball:SKSpriteNode!
    
     override func didMoveToView(view: SKView) {
        
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        self.backgroundColor = UIColor.whiteColor()
        
        physicsBody?.contactTestBitMask = MASK_EDGE
        physicsWorld.contactDelegate = self
        
       ball = childNodeWithName("ball") as SKSpriteNode
        startGameLabel = childNodeWithName("startGameLabel") as SKLabelNode

        
        
    }
    var timer: NSTimer?
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
       if (gameStarted != false){
        let flag = SKSpriteNode(imageNamed: "soccer")
        flag.physicsBody = SKPhysicsBody(rectangleOfSize: flag.frame.size)
        flag.position = touches.anyObject()!.locationInNode(self)
        addChild(flag)
        flag.physicsBody?.contactTestBitMask = MASK_FLAG
        flag.physicsBody?.velocity = CGVector(dx: 0,dy: 500)
        }else{
            gameStarted = true
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody?.contactTestBitMask = MASK_BALL
            startGameLabel.hidden = true
       // timer = NSTimer.scheduledTimerWithTimeInterval(0.01, invocation: self, repeats: false)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact){
        let maskCode = contact.bodyA.contactTestBitMask|contact.bodyB.contactTestBitMask
        if maskCode == MASK_EDGE|MASK_FLAG {
            if  contact.bodyA?.contactTestBitMask==MASK_FLAG{
                contact.bodyA.node?.removeFromParent()
            }
            if contact.bodyB?.contactTestBitMask==MASK_FLAG{
                contact.bodyB.node?.removeFromParent()
            }
        }else if maskCode == MASK_EDGE|MASK_BALL{
            
                self.view?.presentScene(GameOverScene(size: self.frame.size))
            timer?.fireDate
        }
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
