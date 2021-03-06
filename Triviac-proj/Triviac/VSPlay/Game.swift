//
//  Game.swift
//  Triviac
//
//  Created by Anya Ji on 6/15/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation

class Game{
    
    var host = ""
    var joiner: String
    var gameState: Int
    var triviaset: [Trivia]
    /*0: invited - invitations sent
     1: ready/start - all players joined, starts the game
     2: canceled - hosted canceled invite
     */
    
    init(joiner: String, gameState: Int, triviaset: [Trivia]){
      
        self.joiner = joiner
        self.gameState = gameState
        self.triviaset = triviaset
    }
    
    func forDatabase() -> [String: Any] {
        var set: [Dictionary<String, Any>]
        set = triviaset.map({$0.forDatabase()})
        return [
            //"host": host,
            "joiner": joiner,
            "gameState": gameState,
            "triviaset": set
        ]
    }
    
    static func fromDatabase(object: [String: Any]) -> Game {
        //let host = object["host"] as! String
        let joiner = object["joiner"] as! String
        let gameState = object["gameState"] as! Int
        let arrDict = object["triviaset"] as! [[String: Any]]
        let triviaset = arrDict.map({Trivia.fromDatabase(object: $0)})
        
        return Game(joiner: joiner, gameState: gameState, triviaset: triviaset)
    }
}
