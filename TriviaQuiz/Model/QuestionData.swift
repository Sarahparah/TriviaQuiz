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

/**
 Tar in ett QuestionsData objekt. Den skapar upp Answers och formatterar om svaret och frågan.
 */
class Question {
    var questionData : QuestionData
    var formattedAnswers : [Answer] = [Answer]()  //skapar upp ett AnswerArray objekt
    
    init(questionData: QuestionData) {
        self.questionData = questionData
        formattedAnswers = formatAnswers() //binder våra shufflade svar in i formattedAnswers 
    }
    /**
     I denna kalkylerade variabel skapar vi AttributedString där vi har en Do/Catch för att kunna formattera våra frågor.
     */
    var formattedQuestion: AttributedString {
        do {
            return try AttributedString(markdown: questionData.question)
        } catch {
            print("Error setting formattedQuestion: \(error)")
            return ""
        }
    }
    
    /**
     Denna func returnerar en array som innehåller Answer objekt. Här formatteras korrekta och inkorrekta svar och läggs i en array(allAnswers) som sedan shufflas på slutet.
     */
    func formatAnswers() -> [Answer] {
        
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
}
