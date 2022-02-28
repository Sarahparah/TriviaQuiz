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
    let numberOfQuestions = ["10", "20", "30", "40", "50"]
    @Published var quizData: QuizData?
    @Published var isGameEnded = false
    
    func fetchTrivia()  {
        
        let url = URL(string : "https://opentdb.com/api.php?amount=10&type=multiple")
        
        guard url != nil else {
            print("error creating url object")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do{
                    self.quizData = try decoder.decode(QuizData.self, from: data!)
                    let q = self.quizData?.results[self.index].question
                    print(q)
                    
                } catch {
                    print("error")
                }
            }
        }
        dataTask.resume()
    }
    
    func nextQuestion() {
        if index < (quizData!.results.count - 1) {
            index += 1
        } else {
            print("spelet är slut")
            isGameEnded = true
        }
    }
}
