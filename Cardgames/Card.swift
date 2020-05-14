//
//  Card.swift
//  Cardgames
//
//  Created by Bhavika Patel on 1/13/18.
//  Copyright © 2018 Bhavika Patel. All rights reserved.
//

import Foundation

/**
 This struct initializes decks of cards(Creates Cards)
 */
struct Card {
    let rank: Rank
    let suit: Suit
    
    enum Rank: Int {
        case two = 2
        case three, four, five, six, seven, eight, nine, ten
        case Jack, Queen, King, Ace
    }
    
    enum Suit: String {
        case spade = "♠︎"
        case diamond = "♦︎"
        case club = "♣︎"
        case heart = "♥︎"
    }
    
    /**
     This function checks if two cards are equal
     - returns: Bool, if the suit and rank is equal the func returns true
    */
    static func ==(lhs: Card, rhs: Card) -> Bool {
        //the card suit and rank should be equal
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
}

/**
 This function generates a card of deck
 - returns: a deck of card as an array
 */
func generateDeckOfCards() -> [Card] {
    var myDeckOfCards: Array = [Card]()
    let maxRank = Card.Rank.Ace.rawValue
    let aCardSuit:Array = [Card.Suit.spade.rawValue, Card.Suit.diamond.rawValue, Card.Suit.club.rawValue, Card.Suit.heart.rawValue]
    
    for count in 2...maxRank {
        for suit in aCardSuit {
            let aRank = Card.Rank.init(rawValue: count)
            let aSuit = Card.Suit.init(rawValue: suit)
            let myCard = Card(rank: aRank!, suit: aSuit!)
            myDeckOfCards.append(myCard)
        }
    }
    return myDeckOfCards
}
