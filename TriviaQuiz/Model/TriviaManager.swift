//
//  TriviaManager.swift
//  TriviaQuiz
//
//  Created by Yolanda Jonasson on 2022-02-24.
//

import Foundation
import CoreData
import SwiftUI


class TriviaManager : ObservableObject {
    
    var removeThisVariable = 0
    @Published var index: Int = 0
    let numberOfQuestionsArray = ["10", "20", "30", "40", "50"]
    @Published var quizData: QuizData?
    @Published var isGameEnded = false
    var numberOfQuestions = 0
    var category : Int = 0
    var difficulty : String = ""
    var categoryNumbersArray = [0, 9, 10, 11, 12, 14, 15, 17, 22, 23, 25, 32]
    var difficultyArray = ["mix", "easy", "medium", "hard"]
    @Published var questionToDisplay = ""
    var incorrectAnswers : [NSAttributedString] = []
    var correctAnswer = NSAttributedString()
    @Published var allAnswers : [String] = []

    @Published var isColorMode = true

    @Published var allAnswersDecoded : [String] = []
    var backwards = false
    var colorMode = ColorMode()
    @Published var answerSelected = false
    @Published var question: AttributedString = ""
    @Published var answerChoices: [Answer] = []
    @Published var score = 0
    
    
    
//    @State var showAlert: Bool = false
    
    let urlString = "https://opentdb.com/api.php"
    
    func fetchTrivia(with url : URL)  { // 1 5 6 2 4 3
        let session = URLSession(configuration: .default)
        // 1
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil && data != nil {
                return
            }
            // 2
            let decoder = JSONDecoder()
           // decoder.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                // 3
                if let quizData = try? decoder.decode(QuizData.self, from: data!) {
                    self.quizData = quizData
                    // 7
//                    self.alertDialog()
                    
                    self.nextQuestion()
                }
                // 8
            }
            // 4
        }
        // 5
        task.resume()
        // 6
    }
    
    func fetchTheFetchTrivia(amount : Int, category : Int, difficulty : String) {
        guard var urlComps = URLComponents(string: self.urlString) else {
            print("failed to create URLCOMPONENTS")
            return
        }
        var queryItems = [
            
            
            URLQueryItem(name: "amount", value: String(amount)),
            //URLQueryItem(name: "category", value: String(category)),
            // URLQueryItem(name: "difficulty", value: String(difficulty)),
            URLQueryItem(name: "type", value: "multiple"),
            // URLQueryItem(name: "encode", value: "url3986")
        ]
        if difficulty  != "mix" {
            queryItems.append(URLQueryItem(name: "difficulty", value: String(difficulty)))
        }
        if category != 0 {
            queryItems.append(URLQueryItem(name: "category", value: String(category)))
        }
        
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        print("URLLLL:  \(url)")
        
        fetchTrivia(with: url)
        
    }
    
    func decodeHTML(string: String) -> String {
        let dataUTF = Data(string.utf8)
        if let attributedString = try? NSAttributedString(data: dataUTF, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            print("attributedString: \(attributedString)")
            return attributedString.string
        }
        return ""
    }
    
    func nextQuestion() {
        guard let quizData = quizData else {
            return
        }

        if index < (quizData.results.count) {

              self.answerChoices = quizData.results[index].answers
              self.question = quizData.results[index].formattedQuestion
              
//            self.questionToDisplay = self.decodeHTML(string: quizData.results[self.index].question)
//            self.allAnswers = quizData.results[self.index].incorrect_answers
//            self.allAnswers.append(quizData.results[self.index].correct_answer)
//            self.allAnswers.shuffle()
//            print("allAnswers: \(self.allAnswers)")
//            allAnswersDecoded = []
//            for i in 0..<allAnswers.count {
//                allAnswersDecoded.append(decodeHTML(string: allAnswers[i]))
//            }
//            print("allAnswers: \(allAnswers)")
//            print("allAnswersDecoded: \(allAnswersDecoded)")
//            print("allAnswersNewWay \(quizData.results[index].answers)")
//            print("formattedQuestion \(quizData.results[index].formattedQuestion)")

        } else {
            print("spelet är slut")
            isGameEnded = true
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
    
    func resetGame() {
        print("reset game")
    }
    
//    func alertDialog() {
//
//        if quizData!.response_code  > 0 {
//            print("ERRROOOOR RESPOMSSEEEEE CODDDEEE")
//                showAlert = true
//        }
            
        
        
    }
    
    

