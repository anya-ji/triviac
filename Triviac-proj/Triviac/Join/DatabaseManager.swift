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
    
    //static vars
    static var currentGame = Game(joiner: "", gameState: -1, triviaset: [])
    static var opponent: Player!
    static var currentPlayer: Player!
    
    //createVC
    static func createGame(game: Game){
        currentGame = game //update static current game
        currentGame.host = Auth.auth().currentUser!.uid //current user is host
//        //add to db
//        ref.child("games").childByAutoId().updateChildValues(game.forDatabase()){
//            (error, ref) in
//            currentGame.id = ref.key! //add current game id
//            }
        ref.child("games").child(game.host).removeValue()
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
            currentGame.triviaset = game.triviaset
        }
        //change state
         ref.child("games").child(hostID).updateChildValues(["gameState" : 1, "joiner": joinerID])
        
        //set opponent
        findPlayerByUid(uid: hostID) { (player) in
            opponent = player
        }
    }
    
    static func getCurrentGameInfo(hostID: String, completion: @escaping (Game) -> Void){
        ref.child("games").child(hostID).observeSingleEvent(of: .value) { (snapshot) in
            if let gameDict = snapshot.value as? [String : Any]{
                let game = Game.fromDatabase(object: gameDict)
                completion(game)
            }
        }
    }
    
    //VSEndVC
    static func getOpponentScore(opponent: String, completion: @escaping (Int) -> Void){
        ref.child("games").child(currentGame.host).child("scores").child(opponent).observe(.value) { (snapshot) in
            if let opscore = snapshot.value as? Int{
                ref.child("games").child(currentGame.host).child("scores").child(opponent).removeAllObservers()
                completion(opscore)
            }
        }
    }
    
    //VSPlayVC
    static func getPoints(completion: @escaping (Int) -> Void){
        ref.child("users").child(currentPlayer.uid).child("points").observeSingleEvent(of: .value) { (snapshot) in
            if let mypoints = snapshot.value as? Int{
                completion(mypoints)
            }
        }
    }
    static func updatePoints(addPoints: Int){
        getPoints { (mypoints) in
            let newTotal = mypoints + addPoints
            ref.child("users").child(currentPlayer.uid).child("points").setValue(newTotal)
        }
    }
    
    //waitingVC
    static func cancelInvite(){
        //update firebase state
        DatabaseManager.ref.child("games").child(currentGame.host).updateChildValues(["gameState" : 2])
        //change static state
        currentGame.gameState = 2
    }
    
    
    
}
