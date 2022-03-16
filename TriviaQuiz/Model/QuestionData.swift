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
    var correctAnswer: String
    var incorrectAnswers: [String]

}

class Question {
    var questionData : QuestionData
    var answers : [Answer] = [Answer]()
    
    init(questionData: QuestionData) {
        self.questionData = questionData
        answers = makeAnswers()
    }
    
    func makeAnswers() -> [Answer] {
        
        do {
            let correct = [Answer(text: try AttributedString(markdown: questionData.correctAnswer), isCorrect: true)]
            var incorrects = [Answer]()
            for answer in questionData.incorrectAnswers {
                incorrects.append(Answer(text: try AttributedString(markdown: answer), isCorrect: false))
            }
            let allAnswers = correct + incorrects
            return allAnswers.shuffled()
            
        } catch {
            print("Error setting answers: \(error)")
            return []
        }
    }
    
    var formattedQuestion: AttributedString {
        do {
            return try AttributedString(markdown: questionData.question)
        } catch {
            print("Error setting formattedQuestion: \(error)")
            return ""
        }
    }
}

