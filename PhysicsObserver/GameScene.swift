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
		self.physicsWorld.contactDelegate = ContactManager()
		
		
		
		// Make sure our sprites don't escape!
		let edge = SKPhysicsBody(edgeLoopFromRect: self.frame)
		edge.categoryBitMask = PhysicsCategory.Edge
		edge.collisionBitMask = PhysicsCategory.All
		physicsBody = edge
		
		
		
		// Add an 'A' ship
		let ship = createShipAt(CGPoint(x: size.width/2, y: size.height/2 ))
		addChild(ship)
		
		
		// Make it collide with ship B
		let body = SKPhysicsBody(rectangleOfSize: ship.size)
		body.categoryBitMask = PhysicsCategory.A
		body.collisionBitMask = PhysicsCategory.B
		body.contactTestBitMask = PhysicsCategory.B
		ship.physicsBody = body
		
		
		
		// Add an fancy observer!
		ContactManager.shared?.addContactObservation(self, on: ship, with: PhysicsCategory.B) { node, category, contact, type in
			
			switch type {
				
			case .Joining:
				println("Hit!")
				
			default: 
				break
			}
		}
    }
	
	override func willMoveFromView(view: SKView) {
		
		// This is important!
		// Must tell the Contact manager when the scene is removed
		ContactManager.shared?.sceneWasRemoved()
	}
	
	private func createShipAt(position: CGPoint) -> SKSpriteNode {
		
		// Create a new ship, setting its position and scale
		let ship = SKSpriteNode(imageNamed: "Spaceship")
		ship.position = position
		ship.setScale(0.2)
		
		return ship
	}
	
	
	//* MARK: - Scene Touches
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
			
			// Add a 'B' ship where the touch was
			let ship = createShipAt(touch.locationInNode(self))
			addChild(ship)
			
			
			// Add physics to it
			let body = SKPhysicsBody(rectangleOfSize: ship.size)
			body.categoryBitMask = PhysicsCategory.B
			ship.physicsBody = body
			
        }
    }
	
	
}
