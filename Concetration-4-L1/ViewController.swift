//
//  ViewController.swift
//  Concetration-4-L1
//
//  Created by LinuxPlus on 4/22/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
	private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
	
	var numberOfPairsOfCards: Int {
		return (cardButtons.count + 1) / 2
	}
	
	private(set) var flipCount: Int = 0 {
		didSet {
			flipCountLabel.text = ("Flips: \(flipCount)")
		}
	}
	
	@IBOutlet private var flipCountLabel: UILabel!
	
	@IBOutlet private var cardButtons: [UIButton]!
	
	@IBAction private func touchSecondCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			print("cardNumber = \(cardNumber)")
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("Chosen card was not in cardButtons")
		}
	}
	
	private func updateViewFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
			}
		}
	}
	
	private var emojiChoices = ["🦇", "🙀", "😱", "😈", "🎃", "👻", "🍎", "🍭", "🍬"]
	private var emoji = [Int:String]()
	private func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
		}
		return emoji[card.identifier] ?? "?"
	}
}

extension Int {
	var arc4random: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(self)))
		} else {
			return 0
		}
	}
}
