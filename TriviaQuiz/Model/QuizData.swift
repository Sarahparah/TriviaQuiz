//
//  QuizData.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-25.
//

import Foundation

// första lagret av API callbacken
struct QuizData: Decodable {
    var responseCode: Int = 0
    var results: [QuestionData]
}

// Skapar upp en array av klassen Question
class QuizResults {
    var results: [Question] = [Question]()
}
