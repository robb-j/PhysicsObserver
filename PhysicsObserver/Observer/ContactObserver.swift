//
//  ContactObserver.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 26/07/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import SpriteKit


/// An object that describes how an contact observation is made
/// You should only create these through the factory methods: `betweenNode` and `betweenCategory`
///
/// You could subclass to create your own type of observation, implement `shouldObserve()` to 
/// tell `ContactManager` if it should observe a contact.
class ContactObserver {
	
	
	internal let observation: ContactObservation
	
	
	//* MARK: - Observation Lifecycle
	internal init(observation obs: ContactObservation) {
		
		observation = obs
	}
	
	internal func shouldObserver(contact: SKPhysicsContact) -> Bool {
		
		return false
	}
	
	
	
	
	
	//* MARK: - Factory Methods
	
	/// Creates an observation between two given nodes
	class func betweenNode(node nodeA: SKNode, andNode nodeB: SKNode, observation: ContactObservation) -> ContactObserver {
		
		return NodeContactObserver(betweenNode: nodeA, and: nodeB, observation: observation)
	}
	
	/// Creates an observation between a node and given category
	class func betweenNode(node: SKNode, andCategory cat: UInt32, observation: ContactObservation) -> ContactObserver {
		
		return NodeCategoryContactObserver(node: node, category: cat, observation: observation)
	}
	
	/// Creates an observation between two given categories
	class func betweenCategory(category catA: UInt32, andCategory catB: UInt32, observation: ContactObservation) -> ContactObserver {
		
		return CategoryContactObserver(contactBetween: catA, and: catB, observation: observation)
	}
}



internal class CategoryContactObserver: ContactObserver {
	
	let categoryA: UInt32
	let categoryB: UInt32
	
	init(contactBetween catA: UInt32, and catB: UInt32, observation obs: ContactObservation) {
		
		categoryA = catA
		categoryB = catB
		
		super.init(observation: obs)
	}
	
	override func shouldObserver(contact: SKPhysicsContact) -> Bool {
		
		return 
			(contact.bodyA.categoryBitMask == categoryA && contact.bodyB.categoryBitMask == categoryB) || 
				(contact.bodyB.categoryBitMask == categoryA && contact.bodyA.categoryBitMask == categoryB)
	}
}

internal class NodeCategoryContactObserver: ContactObserver {
	
	let node: SKNode
	let category: UInt32
	
	init(node aNode: SKNode, category cat: UInt32, observation obs: ContactObservation) {
		
		node = aNode
		category = cat
		
		super.init(observation: obs)
	}
	
	override func shouldObserver(contact: SKPhysicsContact) -> Bool {
		
		return 
			(contact.bodyA.node === node && contact.bodyB.categoryBitMask == category) ||
				(contact.bodyB.node === node && contact.bodyA.categoryBitMask == category)
	}
}

internal class NodeContactObserver: ContactObserver {
	
	let nodeA: SKNode
	let nodeB: SKNode
	
	init(betweenNode node1: SKNode, and node2: SKNode, observation obs: ContactObservation) {
		
		nodeA = node1
		nodeB = node2
		
		super.init(observation: obs)
	}
	
	override func shouldObserver(contact: SKPhysicsContact) -> Bool {
		
		return 
			(contact.bodyA.node === nodeA && contact.bodyB.node === nodeB) ||
				(contact.bodyB.node === nodeA && contact.bodyA.node === nodeB)
	}
}
