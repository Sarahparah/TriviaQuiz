//
//  TriviaManager.swift
//  TriviaQuiz
//
//  Created by Yolanda Jonasson on 2022-02-24.
//

import Foundation


struct TriviaManager {
    
    var questionArray = ["A", "B", "C", "D", "E", "F"]
    var answerArray = ["1", "2", "3", "4"]
    static var index: Int = 1
    let numberOfQuestions = ["10", "20", "30", "40", "50"]
    
    func fetchTrivia()  {
        
        let url = URL(string : "https://opentdb.com/api.php?amount=10")
        
        guard url != nil else {
            print("error creating url object")
            return
        }
        // var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        // request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do{
                    let dictionary = try decoder.decode(QuizData.self, from: data!)
                    print(dictionary)
                    
                }catch {
                    print("error")
                }
                
            }
        }
        dataTask.resume()
    }
    
    //    func parseJSON(questionData: Data) -> QuestionData? {
    //        let decoder = JSONDecoder()
    //        do {
    //            let decodedData = try decoder.decode(QuizData.self, from: questionData)
    //            let id = decodedData.questionArray[0].id
    //            let type = decodedData.type
    //            let difficulty = decodedData.difficulty
    //            let correctAnswer = decodedData.correctAnswer
    //            let incorrectAnswer = decodedData.incorrectAnswer
    //            let questionArray = decodedData.questionArray
    //            var question: QuestionModel
    //
    //            question = QuizData()
    //            return question
    //        } catch {
    //            print("Error in parseJSON")
    //            return nil
    //        }
    //    }
}
