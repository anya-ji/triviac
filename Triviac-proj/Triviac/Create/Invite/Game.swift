//
//  Game.swift
//  Triviac
//
//  Created by Anya Ji on 6/15/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation

class Game{
    
    var id = ""
    var host: String
    var joiners: [String: Int]
    var gameState: Int
    /*0: invited - invitations sent
     1: ready - all players joined
     2: started - host starts the game
     3: ended - game ended
     */
    
    init(host: String, joiners:[String: Int], gameState: Int){
        self.host = host
        self.joiners = joiners
        self.gameState = gameState
    }
    
    func forDatabase() -> [String: Any] {
        return [
            "host": host,
            "joiners": joiners,
            "gameState": gameState
        ]
    }
    
    static func fromDatabase(object: [String: Any]) -> Game {
        let host = object["host"] as! String
        let joiners = object["joiners"] as! [String : Int]
        let gameState = object["gameState"] as! Int
        
        return Game(host: host, joiners: joiners, gameState: gameState)
    }
}
