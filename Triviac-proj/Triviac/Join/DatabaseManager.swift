//
//  DatabaseManager.swift
//  Triviac
//
//  Created by Anya Ji on 6/15/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager{
    static var ref: DatabaseReference {
          return Database.database().reference(fromURL: "https://triviac-63843.firebaseio.com/")
    }
    
    //static var currentGameID = ""
    static var currentGame = Game(joiner: "", gameState: -1, endpoint: "")
    
    //createVC
    static func createGame(game: Game){
        currentGame = game //update static current game
        currentGame.host = Auth.auth().currentUser!.uid //current user is host
//        //add to db
//        ref.child("games").childByAutoId().updateChildValues(game.forDatabase()){
//            (error, ref) in
//            currentGame.id = ref.key! //add current game id
//            }

        ref.child("games").child(game.host).updateChildValues(game.forDatabase())
      
}
    //joinVC
    static func findPlayerByUid(uid: String, completion: @escaping (Player) -> Void) {
        ref.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let playerDict = snapshot.value as? [String : Any]{
                let player = Player.fromDatabase(object: playerDict)
                //print(player.name)
                completion(player)
            }
        }
    }
    
    //joinVC
    static func confirmJoin(hostID: String, joinerID: String){
        getCurrentGameInfo(hostID: hostID) { (game) in
            currentGame = game
            currentGame.host = hostID
            //update static current game
            CreateViewController.endpoint = currentGame.endpoint
            //update endpoint
        }
        //change state
         ref.child("games").child(hostID).updateChildValues(["gameState" : 1, "joiner": joinerID])
    }
    
    static func getCurrentGameInfo(hostID: String, completion: @escaping (Game) -> Void){
        ref.child("games").child(hostID).observeSingleEvent(of: .value) { (snapshot) in
            if let gameDict = snapshot.value as? [String : Any]{
                let game = Game.fromDatabase(object: gameDict)
                completion(game)
            }
        }
    }
    
    
    
}
