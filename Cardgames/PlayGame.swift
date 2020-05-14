//
//  PlayGame.swift
//  Cardgames
//
//  Created by Bhavika Patel on 1/14/18.
//  Copyright © 2018 Bhavika Patel. All rights reserved.
//

import Foundation

func run(input: String?) {

    // Total number of players to begin the game with
    let numPlayer = 4
    
    // Creats an empty array called players to append an instance of the number of players
    var players: [Player] = []
    for playerIndex in 1...numPlayer {
        players.append(Player())
    }

    // Trump Cards
    let allTrumpValues = [Card.Suit.spade, Card.Suit.diamond, Card.Suit.club, Card.Suit.heart, nil]
    // Beginning of the game all the players begin with a score 0, scores are updated after each round
    var gameScores = Array(repeating: 0, count: numPlayer)
    
    for round in (1...numberOfRounds(numPlayer: numPlayer)) { //loops tho 13 times
        // Loops through the allTrumpValues after each round to get the trump
        // This is how the math works: 4/1|2|3|4|5 -> (6-1) % 5 = 0
        let trump_suit = allTrumpValues[(round - 1) % 5]
        
        // Creating an instance of a player

        // Shuffle then deal the cards
        Dealer.deal(numPlayer: numPlayer, round: round, players: players)

        // Created an empty storePredications array to hold prediction number
        var storePredications:[Int] = []

        // This funtion loops through all the players and store their predictions in storePredications array
        for playerIndex in 0..<numPlayer {
            storePredications.append(players[playerIndex].makePredication(round: round))
        }

        // roundScores is initialised to 0 for all the players before the games starts
        var roundScores = Array(repeating: 0, count: numPlayer)
        
        // The games starts off with player 0 playing his card first
        var startTurn = (round - 1) % numPlayer
        
        
        // This loop, loops through the number of cards per round
        // i.e Each player gets 1 card for round 1, 2 cards for 2 rounds
        for turnNumber in 1...round {
            // Initializing empty play space
            var playedCards:[(Int, Card)] = []
            
            // Everyone plays one card.
            // i.e If player 3 won the turn then player 3 begins the next turn, and then it goes clockwise [3, 0, 1, 2]
            for playerIndex in playerTurnOrder(numPlayer: numPlayer, startTurn: startTurn) {
                if (startTurn == 0) {
                    print(players[0].hand)
                }
                // IF PLAYER 1,
                // MAKE A NEW FUNCTION FOR THE BELOW...
                // PRINT PLAYED CARDS
                // PRINT YOUR HAND
                // WAIT FOR INPUT
                // INPUT A CARD TO PLAY
                
                // User2 plays: Diamond
                // User me has a 2 Club, 5 Diamond, 10 Diamond
                // Game tells me I can play...
                //   Press 1 for 5 Diamond
                //   Press 2 for 10 Diamond
                //
                //   1: 5D 2: 6C 3:.....
                //
                // INPUT> ___
                //        2
                // THINK ABOUT HOW YOU WANNA HANDLE THAT

                playedCards.append((playerIndex, players[playerIndex].playCard(playedCards: playedCards)))
            }
            
            // Once everyone plays a card, we check to see who and which card won
            let winner = whoWinsTheTurn(cardArray: playedCards, trump_suit: trump_suit)

            // Depending on who won the card we assign startTurn to the players index
            startTurn = winner.0

            // We add a point to the winners score and append it to the roundScores array
            roundScores[startTurn] += 1
        }
        // Finds the the round winner
        let currentWinner = roundWinner(roundScores: roundScores, scorePredictions: storePredications)
        
        // Loops through the currentWinner and adds the points to the total gameScores
        // If player 0 and 3 won: then gameScores[0.0] += 0.1, gameScores[3.0] += 3.1
        for winner in currentWinner {
            gameScores[winner.0] += winner.1
        }
    }
    
    // Gets the highest score and find the winner of the overall game
    gameWinner(gameScores: gameScores)
}
