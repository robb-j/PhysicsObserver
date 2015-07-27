//
//  GameScene.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 16/01/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	
	
	//* MARK: - Scene Lifecycle
	override func didMoveToView(view: SKView) {
		
		
		// Set the contact delegate to a new ContactManager
		self.physicsWorld.contactDelegate = ContactManager.shared
		
		
		
		// Make sure our sprites don't escape!
		let edge = SKPhysicsBody(edgeLoopFromRect: self.frame)
		edge.categoryBitMask = PhysicsCategory.Edge
		edge.collisionBitMask = PhysicsCategory.All
		physicsBody = edge
		
		
		
		// Create a 'B' Category ship
		let ship = createShipAt(CGPoint(x: size.width/2, y: size.height/2 ))
		ship.physicsBody?.categoryBitMask = PhysicsCategory.B
		ship.color = SKColor.cyanColor()
		ship.colorBlendFactor = 0.4
		addChild(ship)
		
		
		
		// Listen for collisions
		ContactManager.shared.add(ContactObserver.betweenCategory(category: PhysicsCategory.A, andCategory: PhysicsCategory.B, 
			observation: { (contact, phase) -> (Void) in
			
			if phase == .Began {
				
				println("Hit")
			}
			
		}))
		
	}
	
	override func willMoveFromView(view: SKView) {
		
		// Make sure all observers get removed
		ContactManager.shared.removeAllContactObservers()
	}
	
	private func createShipAt(position: CGPoint) -> SKSpriteNode {
		
		// Create a new ship, setting its position and scale
		let ship = SKSpriteNode(imageNamed: "Spaceship")
		ship.position = position
		ship.setScale(0.2)
		
		
		// Add a physics body
		let body = SKPhysicsBody(rectangleOfSize: CGSize(width: ship.size.width * 0.7, height: ship.size.height * 0.7))
		body.categoryBitMask = PhysicsCategory.A
		body.collisionBitMask = PhysicsCategory.All
		body.contactTestBitMask = PhysicsCategory.B
		ship.physicsBody = body
		
		
		return ship
	}
	
	
	//* MARK: - Scene Touches
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
			
				// Add a 'B' ship where the touch was
				addChild(createShipAt(touch.locationInNode(self)))
        }
    }
	
	
}
