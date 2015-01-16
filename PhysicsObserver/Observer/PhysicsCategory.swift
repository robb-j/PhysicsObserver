//
//  PhysicsCategory.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 16/01/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import Foundation



/// An structure to define your physics categories.
/// Uses swift's binary syntax, remember to add an extra 0 for each new category. 
/// Access with: PhysicsCategory.NAME
struct PhysicsCategory {
	
	static let None		: UInt32 = 0
	static let All 		: UInt32 = UInt32.max
	static let A 		: UInt32 = 0b1
	static let B 		: UInt32 = 0b10
	static let Edge 	: UInt32 = 0b100
	//static let NAME 	: UInt32 = 0b1000
}