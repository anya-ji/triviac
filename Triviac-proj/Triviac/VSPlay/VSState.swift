//
//  VSState.swift
//  Triviac
//
//  Created by Anya Ji on 6/19/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation

class VSState{
    var correct: Int
    var all: Int
    
    init(all: Int){
        self.correct = 0
        self.all = all
    }
    
    func update_correct(){
        self.correct = correct + 1
    }
}
