//
//  QuizData.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-25.
//

import Foundation

struct QuizData: Decodable { // första lagret av API callbacken
    var responseCode: Int = 0
    var results: [QuestionData]

}


class QuizResults { // Skapar upp en array av klassen Question 
    var results: [Question] = [Question]()

}
