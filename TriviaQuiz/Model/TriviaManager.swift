//
//  TriviaManager.swift
//  TriviaQuiz
//
//  Created by Yolanda Jonasson on 2022-02-24.
//

import Foundation


class TriviaManager : ObservableObject {
    
   // var questionArray = ["A", "B", "C", "D", "E", "F"]
   // var answerArray = ["1", "2", "3", "4"]
    @Published var index: Int = 0
    let numberOfQuestionsArray = ["10", "20", "30", "40", "50"]
    @Published var quizData: QuizData?
    @Published var isGameEnded = false
    var numberOfQuestions = 0
    var category : Int = 0
    var difficulty : String = ""

    var score = 0

    var urlString = "https://opentdb.com/api.php?"
    
    func fetchTrivia(with urlString : String)  {

        if let url = URL(string : urlString) {

            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url){
                (data, response, error) in
                if error != nil && data != nil {
                    return
                }

                let decoder = JSONDecoder()

                do {

                    self.quizData = try decoder.decode(QuizData.self, from: data!)
                    let q = self.quizData?.results[self.index].question
                    print(q)

                } catch {

                    print("error")

                }
            }
            task.resume()

        }
        //let url = URL(string : "https://opentdb.com/api.php?amount=10&type=multiple")
        
//        guard url != nil else {
//            print("error creating url object")
//            return
//        }
        
//
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//            if error == nil && data != nil {
//
//                let decoder = JSONDecoder()
//
//                do {
//
//                    self.quizData = try decoder.decode(QuizData.self, from: data!)
//                    let q = self.quizData?.results[self.index].question
//                    print(q)
//
//                } catch {
//                    print("error")
//                }
//            }
//        }
//        task.resume()
    }
    
    func nextQuestion() {
        if index < (quizData!.results.count - 1) {
            index += 1
        } else {
            print("spelet är slut")
            isGameEnded = true
        }
    }


    func fetchTheFetchTrivia(amount : Int, category : Int, difficulty : String) {

        let urlStringEnd = "\(urlString)amount=\(amount)&category=10&difficulty=\(difficulty)&type=multiple"
        fetchTrivia(with: urlString)
        print("Current urlStringEnd = \(urlStringEnd)")
       // performRequest(with: urlString)

    }
}
