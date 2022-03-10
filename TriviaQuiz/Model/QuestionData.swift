//
//  QuestionData.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-25.
//

import Foundation

struct QuestionData: Decodable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
    
    var formattedQuestion: AttributedString {
        do {
            return try AttributedString(markdown: question)
        } catch {
            print("Error setting formattedQuestion: \(error)")
            return ""
        }
    }
    
    var answers: [Answer] {
        
        do {
            let correct = [Answer(text: try AttributedString(markdown: correct_answer), isCorrect: true)]
            var incorrects = [Answer]()
            for answer in incorrect_answers {
                incorrects.append(Answer(text: try AttributedString(markdown: answer), isCorrect: false))
            }
            let allAnswers = correct + incorrects
            return allAnswers.shuffled()
            
        } catch {
            print("Error setting answers: \(error)")
            return []

        }
    }
}
