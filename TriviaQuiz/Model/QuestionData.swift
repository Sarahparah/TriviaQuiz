//
//  QuestionData.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-25.
//

import Foundation

struct QuestionData: Decodable {
    var category: String?
    var type: String?
    var difficulty: String?
    var question: String?
    var correct_answer: String?
    var incorrect_answers: [String]
    
//    func createAllAnswersArray() -> [String] {
//        var allAnswers : [String] = []
//        allAnswers = incorrect_answers
//        allAnswers.append(correct_answer ?? "bla")
//        allAnswers.shuffle()
//        print("All answers: \(allAnswers)")
//    }
}
