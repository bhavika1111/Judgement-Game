//
//  Dealer.swift
//  Cardgames
//
//  Created by Bhavika Patel on 1/14/18.
//  Copyright © 2018 Bhavika Patel. All rights reserved.
//

import Foundation
/**
 This class deals cards, first the dealer shuffles the card in the deck then deals
 */
public class Dealer {
    /**
     This function shuffles the cards in a deck
     - returns: an array of shuffled card deck
     */
    static func _shuffle() -> [Card] {
        var cardItems = generateDeckOfCards()
        var shuffledCards: Array = [Card]()
        for _ in 0..<cardItems.count {
            let rand = Int(arc4random_uniform(UInt32(cardItems.count)))
            shuffledCards.append(cardItems[rand])
            cardItems.remove(at: rand)
        }
        return shuffledCards
    }
    
    /**
     This function calls the shuffle function to shuffle the cards then each player gets
     a card depening on the round number. ie round 1, each player gets 1 card, etc
     - returns: an array of shuffled card deck
     - Parameters:
        - numPlayer: Takes the number of players
        - round: Takes the number of rounds
        - playerHands: Takes in array of cards
     */
    static func deal(numPlayer:Int, round:Int, players: [Player]) {
        var shuffledCards = self._shuffle()
        for dealCycle in 1...round {
            for playerIndex in 0..<numPlayer {
                players[playerIndex].hand.append(shuffledCards.remove(at: 0))
            }
        }
    }
}

