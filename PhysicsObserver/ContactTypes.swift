//
//  ContactTypes.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 26/07/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import SpriteKit









/// The tpye of contact that occured, either joining or leaving
enum ContactPhase { case Began, Ended }


/// A closure to be called when a contact is matched
typealias ContactObservation = (contact: SKPhysicsContact, phase: ContactPhase) -> (Void)




/// A type of contact to be used when removing an observation
enum ContactType {
	
	case Category(UInt32, UInt32)
	case NodeCategory(SKNode, UInt32)
	case Node(SKNode, SKNode)
}




/// Compares a ContactObserver and a ContactType for equality
func == (contact: ContactObserver, type: ContactType) -> Bool {
	
	switch type {
		
	case .Category(let catA, let catB) where contact is CategoryContactObserver:
		
		let cc = contact as! CategoryContactObserver
		return cc.categoryA == cc.categoryA && cc.categoryB == cc.categoryB
		
	case .NodeCategory(let node, let cat) where contact is NodeCategoryContactObserver:
		
		let nc = contact as! NodeCategoryContactObserver
		return nc.node === node && nc.category == cat		
		
	case .Node(let nodeA, let nodeB) where contact is NodeContactObserver:
		
		let nn = contact as! NodeContactObserver
		return nn.nodeA == nodeA && nn.nodeB == nodeB
		
	default:
		return false
	}
}