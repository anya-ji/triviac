//
//  Player.swift
//  Triviac
//
//  Created by Anya Ji on 6/8/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
import UIKit

struct Player: Codable {
    var name: String!
    var uid: String!
    var email: String!
    var color: String!
    
    var points: Int!
    var score: Int!
    
    init(name: String, uid: String, email: String, color: String, points: Int) {
        self.name = name
        self.uid = uid
        self.email = email
        self.color = color
        self.points = points
    }
    
    static func fromDatabase(object: [String: Any]) -> Player {
        let color = object["color"] as! String
        let email = object["email"] as! String
        let name = object["name"] as! String
        let uid = object["uid"] as! String
        let points = object["points"] as! Int
        return Player(name: name, uid: uid, email: email, color: color, points: points)
    }
    
    func forDatabase() -> [String: Any] {
        return [
            "name": name!,
            "uid": uid!,
            "email": email!,
            "color": color!,
            "points": points!
        ]
    }
    
    
    
}
