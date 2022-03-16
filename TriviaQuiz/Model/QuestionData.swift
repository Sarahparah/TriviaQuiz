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
   // var answers: [Answer] = [Answer]()
    
    
//    init(category: String, type: String, difficulty: String, question: String, correct_answer: String, incorrect_answers: [String]) {
//        self.category = category
//        self.type = type
//        self.difficulty = difficulty
//        self.question = question
//        self.correct_answer = correct_answer
//        self.incorrect_answers = incorrect_answers
//        makeAnswers()
//    }
    
//    enum CodingKeys: String, CodingKey {
//        case category
//        case type
//        case difficulty
//        case question
//        case correct_answer // = correct_answer
//        case incorrect_answers
//    }
//
//    init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            category = try container.decode(String.self, forKey: .category)
//            type = try container.decode(String.self, forKey: .type)
//            difficulty = try container.decode(String.self, forKey: .difficulty)
//            question = try container.decode(String.self, forKey: .question)
//            correct_answer = try container.decode(String.self, forKey: .correct_answer)
////            incorrect_answers = try container.decode([String].self, forKey: .incorrect_answers)
////            let details = try container.nestedContainer(keyedBy: DetailsCodingKeys.self, forKey: .details)
////            isHelpful = try details.decode(Bool.self, forKey: .isHelpful)
//
//        }
//    func decode(to decoder: Decoder) throws {
//            var container = decoder.container(keyedBy: CodingKeys.self)
//            try container.decode(category, forKey: .category)
//            try container.decode(type, forKey: .type)
//            try container.decode(difficulty, forKey: .difficulty)
//            try container.decode(question, forKey: .question)
//            try container.decode(correct_answer, forKey: .correct_answer) // refactor första
//            try container.decode(incorrect_answers, forKey: .incorrect_answers)
//        }
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
            let correct = [Answer(text: try AttributedString(markdown: questionData.correct_answer), isCorrect: true)]
            var incorrects = [Answer]()
            for answer in questionData.incorrect_answers {
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

