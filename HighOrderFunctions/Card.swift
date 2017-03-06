//
//  Card.swift
//  HighOrderFunctions
//
//  Created by Jim Campagno on 3/4/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit
import GameKit

protocol PlayingCard {
    var rank: Rank { get }
    var suit: Suit { get }
}


final class Card: PlayingCard {
    
    let rank: Rank
    let suit: Suit
    let image: UIImage
    var isFaceUp: Bool = true
    var value: Int {
        return rank.value
    }
    
    init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
        let imageName = rank.description + suit.description
        image = UIImage(named: imageName)!
    }
    
    func flipCard() {
        isFaceUp = !isFaceUp
    }
    
}

extension Card: CustomStringConvertible {
    
    var description: String {
        var suitString: String
        switch suit {
        case.clubs:
            suitString = "♣️"
        case .spades:
            suitString = "♠️"
        case .diamonds:
            suitString = "♦️"
        case .hearts:
            suitString = "♥️"
        }
        return suitString + rank.description
    }
    
}

// MARK: - Sort Methods
extension Array where Element: PlayingCard {
    
    mutating func sortCards() {
        self = self.sorted(by: { (card1, card2) -> Bool in
            var card1Value = card1.rank.value
            var card2Value = card2.rank.value
            if let a = Suit.all.index(of: card1.suit) { card1Value += (a * 100) }
            if let b = Suit.all.index(of: card2.suit) { card2Value += (b * 100) }
            return card1Value > card2Value
        })
        print(self)
    }
    
    mutating func shuffle() {
        self = GKRandomSource().arrayByShufflingObjects(in: self) as! Array<Iterator.Element>
    }
    
   func getScore() -> Int {
        var total: Int = 0
        self.forEach({total +=  $0.rank.value})
        return total
    }
    
}
