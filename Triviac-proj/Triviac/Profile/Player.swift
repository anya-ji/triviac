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
    var email: String!
    //var color: String!
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
        //self.color = color
    }
    
    static func fromDatabase(object: [String: Any]) -> Player {
        let name = object["name"] as! String
        let email = object["email"] as! String
        //let color = object["color"] as! String
        return Player(name: name, email: email)
    }
    
    func forDatabase() -> [String: Any] {
        return [
            "name": name!,
            "email": email!
            //"color": color!
        ]
    }
    
    
    
}
