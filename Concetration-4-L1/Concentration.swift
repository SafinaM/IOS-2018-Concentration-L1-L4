//
//  Concetration.swift
//  Concetration-4-L1
//
//  Created by LinuxPlus on 11/17/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import Foundation

// class is passed as reference
// struct is copy
struct Concentration
{
	private(set) var cards = [Card]()
	
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			return  cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
//			var foundIndex: Int?
//			for index in cards.indices {
//				if cards[index].isFaceUp {
//					if foundIndex == nil {
//						foundIndex = index
//					} else {
//						return nil
//					}
//				}
//			}
//			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	mutating func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): shosen index not in the cards")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//				check if cards match
				if cards[matchIndex] == cards[index] {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
		for _ in 0..<numberOfPairsOfCards {
			let card = Card()
			self.cards += [card, card]
		}
	}
}

extension Collection {
	var oneAndOnly: Element? {
		return count == 1 ? first : nil
	}
}
