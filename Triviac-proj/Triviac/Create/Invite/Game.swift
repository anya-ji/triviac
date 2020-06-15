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
    var joiners: [String: Bool]
    var gameState: Int
    /*0: invited - invitations sent
     1: ready - all players joined
     2: started - host starts the game
     3: ended - game ended
     */
    
    init(host: String, joiners:[String: Bool], gameState: Int){
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
}
