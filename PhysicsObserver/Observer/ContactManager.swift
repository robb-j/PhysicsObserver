//
//  ContactManager.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 16/01/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import SpriteKit






/// A Singleton class that adds and removes contact observations
class ContactManager: NSObject, SKPhysicsContactDelegate {
	
	
	/// Accesses the shared instance of `ContactManager`
	static var shared = ContactManager()
	
	
	private var allObservations = [ContactObserver]()
	
	
	
	//* MARK: - SKPhysicsContactDelegate
	func didBeginContact(contact: SKPhysicsContact) {
		
		for observer in allObservations {
			
			if observer.shouldObserver(contact) {
				
				observer.observation(contact: contact, phase: .Began)
			}
		}
	}
	
	func didEndContact(contact: SKPhysicsContact) {
		
		for observer in allObservations {
			
			if observer.shouldObserver(contact) {
				
				observer.observation(contact: contact, phase: .Ended)
			}
		}
	}
	
	
	
	
	//* MARK: - Observation Management
	
	/// Add an Observation
	func add(observer: ContactObserver) {
		
		allObservations.append(observer)
	}
	
	/// Remove an observation by reference
	func remove(observer: ContactObserver) {
		
		allObservations = allObservations.filter({ (obs) -> Bool in
			return obs !== observer
		})
	}
	
	/// Remove an observation by type
	func remove(type: ContactType) {
		
		allObservations = allObservations.filter({ (obs) -> Bool in
			return (obs == type) == false
		})
	}
	
	/// Remove all observations
	func removeAllContactObservers() {
		
		allObservations = []
	}
}