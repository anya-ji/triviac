//
//  Trivia.swift
//  Triviac
//
//  Created by Anya Ji on 5/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
struct Trivia: Codable{
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
    
    init(question: String, correct_answer: Bool) {
        self.question = question
        self.correct_answer = String(correct_answer)
        self.category = ""
        self.type = ""
        self.difficulty = ""
        self.incorrect_answers = []
    }
}

//for saved
struct TriviaObj: Codable {
    var title: String
    var set: [Trivia]
    
    init(set: [Trivia], title: String){
        self.set = set
        self.title = title
    }
}

struct TriviaResponse: Codable {
   var response_code: Int
    var results: [Trivia]
}
