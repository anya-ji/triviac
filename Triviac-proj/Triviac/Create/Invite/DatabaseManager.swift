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
    
    static func createGame(game: Game){
        ref.child("games").childByAutoId().updateChildValues(game.forDatabase())
}
    static func findPlayerNameByUid(uid: String, completion: @escaping (String) -> Void) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let playerDict = snapshot.value as? [String : Any]{
                let player = Player.fromDatabase(object: playerDict)
                print(player.name)
                completion(player.name)
            }
        }
    }
    
}
