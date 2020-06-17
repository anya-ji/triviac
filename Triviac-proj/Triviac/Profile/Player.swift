//
//  Player.swift
//  Triviac
//
//  Created by Anya Ji on 6/8/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
import UIKit

struct Player {
    var name: String!
    var uid: String!
    var email: String!
    //var points: Int!
    var color: String!
    var inGame: String!
    
    init(name: String, uid: String, email: String, color: String) {
        self.name = name
        self.uid = uid
        self.email = email
        self.color = color
    }
    
    static func fromDatabase(object: [String: Any]) -> Player {
        let color = object["color"] as! String
        let email = object["email"] as! String
        let name = object["name"] as! String
        let uid = object["uid"] as! String
        return Player(name: name, uid: uid, email: email, color: color)
    }
    
    func forDatabase() -> [String: Any] {
        return [
            "name": name!,
            "uid": uid!,
            "email": email!,
            "color": color!
        ]
    }
    
    
    
}
