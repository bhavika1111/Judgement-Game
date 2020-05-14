//
//  GameEngine.swift
//  Cardgames
//
//  Created by Bhavika Patel on 1/14/18.
//  Copyright © 2018 Bhavika Patel. All rights reserved.
//

import Foundation

/**
 This function takes in the num of players and divide it by the
 total cards(52) to figure out the max round for the game (it rounds the total)
 - returns: Int, the total number of round
 */
func numberOfRounds(numPlayer: Int) -> Int {
    return Int(floor(Double(52/numPlayer)))
}

/**
 This function compares the winning card with the next persons card and returns a winning card
 - returns: a winning card
 - Parameters:
    - currentWinningCard: Takes the current winning card
    - competingCard: Takes the next persons card
    - starter_suit: Takes in the suit of the first persons card
    - trump_suit: Takes in the trump suit for the round
 */
func whoWins(currentWinningCard: Card, competingCard: Card, starter_suit: Card.Suit, trump_suit: Card.Suit?) -> Card {
    var currentWinningCard = currentWinningCard
    
    if currentWinningCard.suit == competingCard.suit {
        if currentWinningCard.rank.rawValue < competingCard.rank.rawValue {
            currentWinningCard = competingCard
        }
    } else {
        if competingCard.suit == starter_suit {
            if currentWinningCard.suit != trump_suit  {
                if currentWinningCard.rank.rawValue < competingCard.rank.rawValue {
                    currentWinningCard = competingCard
                }
            }
        } else {
            if currentWinningCard.suit != trump_suit {
                if currentWinningCard.suit.rawValue == competingCard.suit.rawValue ||
                    competingCard.suit == trump_suit {
                    currentWinningCard = competingCard
                }
            }
        }
    }
    return currentWinningCard
}

/**
 This function returns the winning player and the winning card
 - returns: a winning tuple(which person won, what card won)
 - Parameters:
    - cardArray: It's a tuple(takes in an int: what player its, Card: the player's card)
     - trump_suit: Takes an optional card suit as the trump could also be nil
 */
func whoWinsTheTurn(cardArray: [(Int, Card)], trump_suit: Card.Suit?) -> (Int, Card) {
    // Beginning of the game the currenWinningCard is players 0.
    var currentWinningCard = cardArray[startTurn!].1
    //    print(Int(cardArray[startTurn!].0))
    let starter_suit = cardArray[0].1.suit
    var winningPlayer = cardArray[0]
    
    // Loops through the cardArray of the number of the players, compares everyone's card and
    // returns a winning card
    for i in 1..<cardArray.count {
        currentWinningCard = whoWins(currentWinningCard: currentWinningCard,
                                     competingCard: cardArray[i].1,
                                     starter_suit: starter_suit,
                                     trump_suit: trump_suit)
    }
    // Loops thu the cardArray to figure out who the card winner is
    for card in cardArray {
        if (card.1 == currentWinningCard) {
            winningPlayer = card
        }
    }
    // The winner starts the next turn
    startTurn = Int(winningPlayer.0)
    
    return winningPlayer
}

/**
 This function decides the next player turn. ie. if players were [0, 1, 2, 3] and the
 winner was [1], then the turn order should be [1, 2, 3, 0]
 - returns: an array of the player turn order
 - Parameters:
    - numPlayer: int, the total number of players
    - trump_suit: int, the person who starts the turn
 */
func playerTurnOrder(numPlayer: Int, startTurn: Int) -> [Int] {
    var emptyArray:[Int] = []
    
    for beforePlayers in startTurn..<numPlayer {
        emptyArray.append(beforePlayers)
    }
    for afterPlayers in 0..<startTurn {
        emptyArray.append(afterPlayers)
    }
    
    return emptyArray
}

// Returns an array of tuple (playerNumber, score)
var individualGameScore:[(Int, Int)] = []
// startTurn is optional int
var startTurn:Int? = 0 //why is it optional, forgot...

/**
 This function finds the highest score and the person with the highest score and
 returns the winner
 - returns: an array of the person who won the game with highest score
 - Parameters:
     - gameScores: int, returns the highest game score
 */
func gameWinner(gameScores: [Int]) -> [Int] {
    // Loops through the score for all the players and gets the
    // highest score
    var winningScore: Int = 0
    for scoreIndex in 0..<gameScores.count {
        if gameScores[scoreIndex] > winningScore {
            winningScore = gameScores[scoreIndex]
        }
    }
    
    // Loops through all the players and finds the person who has the
    // highest score
    var winningPlayerIndices: [Int] = []
    for i in 0..<gameScores.count {
        if (winningScore == gameScores[i]) {
            winningPlayerIndices.append(i)
        }
    }
    
    return winningPlayerIndices
}

/**
 This function returns the round winner(round winner is defined is the players
 score equals the prediction score)
 - returns: an array tuple(the person who won, the score of the person)
 - Parameters:
     - roundScores: int, score of a person for the round
     - scorePredictions: int, hands(score) predicted before the round start
 */
func roundWinner(roundScores: [Int], scorePredictions: [Int]) -> [(Int,Int)] {
    // We go through the round score and see if it matches the score prediction,
    // if it does we multiple it by 10 and return it as a tuple (the player, the score)
    // if the player's score was 0 and the prediction was 0, the player gets 10 points
    var winners:[(Int,Int)] = []
    for i in 0..<roundScores.count {
        if roundScores[i] == scorePredictions[i] {
            if (roundScores[i] == 0) {
                winners.append((i,10))
            } else {
                winners.append((i,roundScores[i]*10))
            }
        }
    }
    
    return winners
}
