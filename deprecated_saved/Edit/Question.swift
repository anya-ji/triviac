//
//  Question.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
class Question: NSObject, Codable{
    
    var q: String!
    var tf: Bool!
    
    
    init(q:String, tf:Bool){
        self.q = q
        self.tf = tf
    }
    
}
