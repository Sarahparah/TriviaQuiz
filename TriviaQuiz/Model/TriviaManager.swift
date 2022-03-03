//
//  TriviaManager.swift
//  TriviaQuiz
//
//  Created by Yolanda Jonasson on 2022-02-24.
//

import Foundation


class TriviaManager : ObservableObject {
    
    var removeThisVariable = 0
    @Published var index: Int = 0
    let numberOfQuestionsArray = ["10", "20", "30", "40", "50"]
    @Published var quizData: QuizData?
    @Published var isGameEnded = false
    var numberOfQuestions = 0
    var category : Int = 0
    var difficulty : String = ""
    var categoryNumbersArray = [9, 10, 11, 12, 14, 15, 17, 22, 23, 25, 32]
    var allAnswers : [String] = []

    var score = 0

    let urlString = "https://opentdb.com/api.php"
    
    func fetchTrivia(with url : URL)  {
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil && data != nil {
                return
            }

            let decoder = JSONDecoder()
            DispatchQueue.main.async {
                do  {
                    _ = try decoder.decode(QuizData.self, from: data!)
                } catch {
                    print(error)
                }
                if let quizData = try? decoder.decode(QuizData.self, from: data!) {
                    self.quizData = quizData
                    let q = quizData.results[self.index].question
                    print(q)
                    self.allAnswers = quizData.results[self.index].incorrect_answers ?? ["A","B","C"]
                    self.allAnswers.append(quizData.results[self.index].correct_answer ?? "D")
                   // print("allAnswers: \(self.allAnswers)")
                }
            }
        }
        task.resume()
        
    }
    
    func nextQuestion() {
        if index < (quizData!.results.count - 1) {
            index += 1
        } else {
            print("spelet är slut")
            isGameEnded = true
        }
    }
    
    func resetGame() {
        print("reset game")
    }

    func fetchTheFetchTrivia(amount : Int, category : Int, difficulty : String) {
        guard var urlComps = URLComponents(string: self.urlString) else {
            print("failed to create URLCOMPONENTS")
            return
        }
        let queryItems = [

            URLQueryItem(name: "amount", value: String(amount)),
            URLQueryItem(name: "category", value: String(category)),
            URLQueryItem(name: "difficulty", value: String(difficulty)),
            URLQueryItem(name: "type", value: "multiple")
        ]
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }

        fetchTrivia(with: url)
       // print("Current urlStringEnd = \(url)")
        
    }
}
