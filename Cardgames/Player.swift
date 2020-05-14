//
//  Player.swift
//  Cardgames
//
//  Created by Bhavika Patel on 1/14/18.
//  Copyright © 2018 Bhavika Patel. All rights reserved.
//

import Foundation
/**
 This class defines a player who has a hand, who could make predictions, and play cards
 */
class Player {
    // All the players begins with 0 cards in their hands
    var hand:[Card]
    
    init() {
        self.hand = []
    }
    /**
     This function chooses a random number for score prediction
     - returns: a random number from 0 to round
     - Parameters:
        - round: Takes the number of rounds
     */
    func makePredication(round: Int) -> Int {
        return Int(arc4random_uniform(UInt32(round)))
    }
    
    
    func sameSuitAsStaterSuit(starter_suit: Card.Suit) -> [Card] {
        var tempArray:[Card] = []
        // Looping through all the cards and appending to an array if its the same as the starter_suit
        for cardsInHand in self.hand {
            if (cardsInHand.suit == starter_suit) {
                tempArray += [cardsInHand]
            }
        }
        
        return tempArray
    }
    
    func availableCardsToPlay(starter_suit: Card.Suit) -> [Card] {
        let cardsSameAsStarterSuit = sameSuitAsStaterSuit(starter_suit: starter_suit)
        
        if (cardsSameAsStarterSuit.isEmpty) {
            return self.hand
        }
        
        return cardsSameAsStarterSuit
    }
    
    func indexOfCardToPlay(chosenCard: Card) -> Int {
        var chosenCardIndex: Int? = nil
        for i in 0..<self.hand.count {
            if (self.hand[i] == chosenCard) {
                chosenCardIndex = i
                break
            }
        }
        
        return chosenCardIndex!
    }

    /**
     This function players plays the card (remove a card from hand)
     - returns: a card that the player plays
     - Parameters:
         - playerHands: Takes an array of all the card in players hand
         - playerIndex: What player it is (player number)
     */
    func playCard(playedCards: [(Int, Card)]) -> Card {
        let cardRemoveIndex: Int
        
        if (playedCards.isEmpty) {
            cardRemoveIndex = Int(arc4random_uniform(UInt32(self.hand.count)))
        } else {
            let starter_suit = playedCards[0].1.suit
            let playableCards = availableCardsToPlay(starter_suit: starter_suit)
            let indexOfPlayableCard = Int(arc4random_uniform(UInt32(playableCards.count)))
            cardRemoveIndex = indexOfCardToPlay(chosenCard: playableCards[indexOfPlayableCard])
        }
    
        let higherCard = self.hand.remove(at: cardRemoveIndex)
        return higherCard
        
    }
}



// COMPARE THE SUIT
// GET THE HIGHER RANK
// SAVE THE INDEX
// IF NONE OF THE CARD IS AS THE SAME SUIT RETURN A RANDOM CARD
