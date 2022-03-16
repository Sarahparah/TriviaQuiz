//
//  QuizData.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-25.
//

import Foundation

struct QuizData: Decodable {
    var response_code: Int = 0
    var results: [QuestionData]
}

class QuizResults {
    var results: [Question] = [Question]()
}
