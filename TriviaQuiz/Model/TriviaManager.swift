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
    var quizData: QuizData?
    var quizResults: QuizResults?
    
    var numberOfQuestions = 0
    var category : Int = 0
    var difficulty : String = ""
    var categoryNumbersArray = [0, 9, 10, 11, 12, 14, 15, 17, 22, 23, 25, 32]
    var difficultyArray = ["mix", "easy", "medium", "hard"]
    @Published var isColorMode = true
    @Published var answerSelected = false
    @Published var question: AttributedString = ""
    var answerChoices: [Answer] = []
    @Published var score = 0
    @Published var responseCodeError = false
    @Published var isGameEnded = false
    @Published var backToSettings = false
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
    
    func fetchTrivia(with url : URL)  {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil && data != nil {
                return
            }
            let decoder = JSONDecoder()
            DispatchQueue.main.async {
                if let quizData = try? decoder.decode(QuizData.self, from: data!) {
                    self.quizData = quizData
                    self.quizResults = QuizResults()
                    if quizData.response_code == 1 {
                        self.responseCodeError = true
                    } else {
                        for question in quizData.results {
                            var question2 = Question(questionData: question)
                            self.quizResults?.results.append(question2)
                        }
                        self.nextQuestion()
                        self.isTriviaViewActive = true
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchTheFetchTrivia(amount : Int, category : Int, difficulty : String) {
        guard var urlComps = URLComponents(string: self.urlString) else {
            print("failed to create URLCOMPONENTS")
            return
        }
        var queryItems = [
            URLQueryItem(name: "amount", value: String(amount)),
            URLQueryItem(name: "type", value: "multiple"),
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
        guard let quizResults = quizResults else {
            return
        }
        if index < (quizResults.results.count) {
            self.answerChoices = quizResults.results[index].answers
            self.question = quizResults.results[index].formattedQuestion
            index += 1
            progressBarProgress = 0.0
            
        } else {
            print("spelet är slut")
            isScoreViewActive = true
            isGameEnded = true
        }
    }
    
    func selectAnswer(answer: Answer) {
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
        quizResults = nil
        responseCodeError = false
    }
}



