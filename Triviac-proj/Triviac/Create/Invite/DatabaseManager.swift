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
}
