//
//  ContactManager.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 16/01/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import SpriteKit



//* MARK: - Ideas
// - Different types of collision (category - category), (node - node), ... ?




/// Enum for telling callbacks what type of observation is occuring
enum ContactType {
	
	case Joining
	case Leaving
}



/// A Closure used for ContactManager callbacks
typealias ContactCallback = (node: SKNode, category: UInt32, contact: SKPhysicsContact, type: ContactType) -> Void



/// Property allowing singleton access through ContactManger.shared
private var _sharedManager: ContactManager? = nil



/// A Singleton SKPhysicsContactDelegate that provides objects to register closures 
/// to be called when a specific node collides with a physics category, 
/// ie a player node collides with a Platform category
class ContactManager: NSObject, SKPhysicsContactDelegate {
	
	
	/// Structure used for storing observations
	private struct ContactObservation {
		
		let node: SKNode
		let category: UInt32
		let observer: AnyObject
		let callback: ContactCallback
	}
	
	/// The stored observations
	private var _allObservations = [ContactObservation]()
	
	
	
	//* MARK: - Object Lifecycle
	override init() {
		
		// Assert singleton
		if _sharedManager != nil {
			
			fatalError("Cannot create multiple ContactManger instances, remember to call sceneWasRemoved() when a scene is removed")
		}
		
		
		super.init()
		
		
		_sharedManager = self
	}
	
	/// Must be called when a scene is removed!
	func sceneWasRemoved() {
		
		_allObservations = []
		_sharedManager = nil
	}
	
	
	
	//* MARK: - Singleton Access
	class var shared: ContactManager? {
		
		return _sharedManager
	}
	
	
	
	
	//* MARK: - Observation Management
	/// Add a ContactObservation
	///
	/// :param: observer The object that is responsible for the observation
	/// :param: on The node to be observered
	/// :param: with The category to check for collisions with
	/// :param: callback The closure that'll get called when a collision occurs
	func addContactObservation(observer: AnyObject, on: SKNode, with: UInt32, callback: ContactCallback) {
		
		_allObservations.append(ContactObservation(node: on, category: with, observer: observer, callback: callback))
	}
	
	/// Remove all observations for a given observer
	///
	/// :param: from The observer to remove callbacks from
	func removeContactObservationsFrom(observer: AnyObject) {
		
		_allObservations = _allObservations.filter { observation in
			return observation.observer !== observer
		}
	}
	
	/// Simply remove every observation
	func removeAllContactObservations() {
		
		_allObservations = []
	}
	
	
	
	
	//* MARK: - SKPhysicsContactDelegate
	func didBeginContact(contact: SKPhysicsContact) {
		
		for obs in _allObservations {
			
			if compareContact(contact, with: obs) {
				
				obs.callback(node: obs.node, category: obs.category, contact: contact, type: .Joining)
			}
		}
	}
	
	func didEndContact(contact: SKPhysicsContact) {
		
		for obs in _allObservations {
			
			if compareContact(contact, with: obs) {
				
				obs.callback(node: obs.node, category: obs.category, contact: contact, type: .Leaving)
			}
		}
	}
	
	private func compareContact(contact: SKPhysicsContact, with observation: ContactObservation) -> Bool {
		
		
		if contact.bodyA.categoryBitMask == observation.category || contact.bodyB.categoryBitMask == observation.category {
			
			return contact.bodyA.node? == observation.node || contact.bodyB.node? == observation.node
		}
		return false
	}
	
	
}