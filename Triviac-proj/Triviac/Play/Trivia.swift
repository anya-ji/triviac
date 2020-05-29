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
    
    init(question: String, correct_answer: String) {
        self.question = question
        self.correct_answer = correct_answer
        self.category = ""
        self.type = ""
        self.difficulty = ""
        self.incorrect_answers = []
    }
}

//for saved
struct TriviaObj: Codable {
    var title: String
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var score: String
    var set: [Trivia]
    var id = Date()
    
    init(title: String, set: [Trivia], score: String){
        self.title = title
        self.set = set
        self.category = set[0].category
        self.difficulty = set[0].difficulty
        self.type = set[0].type
        self.question = set[0].question
        self.score = score
        self.id = Date()
    }
    
}

struct TriviaResponse: Codable {
   var response_code: Int
    var results: [Trivia]
}
