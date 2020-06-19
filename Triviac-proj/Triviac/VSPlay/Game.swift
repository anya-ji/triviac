//
//  Game.swift
//  Triviac
//
//  Created by Anya Ji on 6/15/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation

class Game{
    
    //var id = ""
    var host = ""
    var joiner: String
    var gameState: Int
    var endpoint: String
    /*0: invited - invitations sent
     1: ready - all players joined
     2: started - host starts the game
     3: ended - game ended
     */
    
    init(joiner: String, gameState: Int, endpoint: String){
       // self.host = host
        self.joiner = joiner
        self.gameState = gameState
        self.endpoint = endpoint
    }
    
    func forDatabase() -> [String: Any] {
        return [
            //"host": host,
            "joiner": joiner,
            "gameState": gameState,
            "endpoint": endpoint
        ]
    }
    
    static func fromDatabase(object: [String: Any]) -> Game {
        //let host = object["host"] as! String
        let joiner = object["joiner"] as! String
        let gameState = object["gameState"] as! Int
        let endpoint = object["endpoint"] as! String
        
        return Game(joiner: joiner, gameState: gameState, endpoint: endpoint)
    }
}
