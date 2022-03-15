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
    
    
    @Published var index: Int = 0
    @Published var quizData: QuizData?
    
    var numberOfQuestions = 0
    var category : Int = 0
    var difficulty : String = ""
    var categoryNumbersArray = [0, 9, 10, 11, 12, 14, 15, 17, 22, 23, 25, 32]
    var difficultyArray = ["mix", "easy", "medium", "hard"]
    //var incorrectAnswers : [NSAttributedString] = []
    //var correctAnswer = NSAttributedString()
    @Published var isColorMode = true
    // var colorMode = ColorMode()
    @Published var answerSelected = false
    @Published var question: AttributedString = ""
   // @Published
    var answerChoices: [Answer] = []
    @Published var score = 0
    @Published var responseCodeError = false
    @Published var isGameEnded = false
    @Published var backToSettings = false
    
    //@Published var startTimer = false
    
    //    @Published var circularProgressBar : CircularProgressBar?
    
    @Published var progressBarProgress = 0.0
    
    @Published var isSettingsViewActive = false {
        didSet {
            print("isSettingsViewActive \(isSettingsViewActive)")
        }
    }
    @Published var isTriviaViewActive = false{
        didSet {
            print("isTriviaViewActive \(isTriviaViewActive)")
        }
    }
    @Published var isScoreViewActive = false{
        didSet {
            print("isScoreViewActive \(isScoreViewActive)")
        }
    }
    @Published var isHighScoreViewActive = false
    @Published var isAnswerViewActive = false{
        didSet {
            print("isAnswerViewActive \(isAnswerViewActive)")
        }
    }
    
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
                    if quizData.response_code == 1 {
                        self.responseCodeError = true
                        
                    } else {
                        self.nextQuestion()
                        self.isTriviaViewActive = true
                        
                    }
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
    
    func nextQuestion() {
        guard let quizData = quizData else {
            return
        }
        
        if index < (quizData.results.count) {
            
            self.answerChoices = quizData.results[index].answers
            self.question = quizData.results[index].formattedQuestion
            index += 1
           // self.startTimer = true
            progressBarProgress = 0.0
            
        } else {
            print("spelet är slut")
            isScoreViewActive = true
            isGameEnded = true
        }
    }
    
    func selectAnswer(answer: Answer) {
      //  answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
    
    func resetGame() {
        print("reset game")
        index = 0
        score = 0
        isGameEnded = false
        quizData = nil
        responseCodeError = false
      //  progressBarProgress = 1.0

    }
    
    //    func alertDialog() {
    //
    //        if quizData!.response_code  > 0 {
    //            print("ERRROOOOR RESPOMSSEEEEE CODDDEEE")
    //                showAlert = true
    //        }
    
    
    
}



