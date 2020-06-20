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
    
    init(category: String, type: String, difficulty: String, question: String, correct_answer: String, incorrect_answers: [String]) {
        self.question = question
        self.correct_answer = correct_answer
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.incorrect_answers = incorrect_answers
    }
    
    static func fromDatabase(object: [String: Any]) -> Trivia {
        let category = object["category"] as! String
        let type = object["type"] as! String
        let difficulty = object["difficulty"] as! String
        let question = object["question"] as! String
        let correct_answer = object["correct_answer"] as! String
        let incorrect_answers = object["incorrect_answers"] as! [String] //when extract from firebase, it directly converts to array instead of dictionary with 1..n keys
       // let incorrect_answers = Array(arrDict.values)
        return Trivia(category: category, type: type, difficulty: difficulty, question: question, correct_answer: correct_answer, incorrect_answers: incorrect_answers)
    }
    
    func forDatabase() -> [String: Any] {
        return [
            "category": category,
            "type": type,
            "difficulty": difficulty,
            "question": question,
            "correct_answer": correct_answer,
            "incorrect_answers": incorrect_answers //store array to firebase
        ]
    }
}

//for saved
struct TriviaObj: Codable {
    var title: String
    var category: String
    var type: String
    var difficulty: String
    //var question: String
    var score: String
    var set: [Trivia]
    var id = Date()
    
    init(title: String, set: [Trivia], score: String){
        self.title = title
        self.set = set
        //differentiate any category and others
        let catArr = set.map({$0.category})
        let catSet = NSSet(array: catArr)
        if catSet.count == 1{
            self.category = set[0].category
        }
        else{
            self.category = "Any Category"
        }
        self.difficulty = set[0].difficulty
        self.type = set[0].type
        //self.question = set[0].question
        self.score = score
        self.id = Date()
    }
    
}

struct TriviaResponse: Codable {
   var response_code: Int
    var results: [Trivia]
}
