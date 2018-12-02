//
//  Card.swift
//  Concetration-4-L1
//
//  Created by LinuxPlus on 11/17/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import Foundation

// struct not inheritance, value type - copied
struct Card : Hashable
{
	var hashValue: Int {
		return identifier
	}
	
	static func ==(lhs: Card, rhs: Card) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	var isFaceUp = false
	var isMatched = false
	private var identifier: Int
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
