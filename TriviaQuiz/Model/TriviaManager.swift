//
//  TriviaManager.swift
//  TriviaQuiz
//
//  Created by Andreas Jonasson on 2022-02-24.
//

import Foundation
import CoreData
import SwiftUI

class TriviaManager : ObservableObject { // ObservableObject, dvs. andra vyer som kollar på klassens variabler

    var quizData: QuizData?
    var quizResults: QuizResults?
    
    var categoryNumbersArray = [0, 9, 10, 11, 12, 14, 15, 17, 22, 23, 25, 32]
    var difficultyArray = ["mix", "easy", "medium", "hard"]
    
    @Published var index: Int = 0
    @Published var numberOfQuestions = 0
    @Published var isColorMode = true  //Publicerad variabel som tas emot på andra ställen!
    
    @Published var question: AttributedString = ""
    @Published var answerChoices: [Answer] = []
    
    @Published var score = 0
    
    @Published var responseCodeError = false
    @Published var isGameEnded = false
    @Published var backToSettings = false
    
    @Published var progressBarProgress = 0.0
    var timerSounds = Sounds()

    // Dessa fem variabler använder vi oss av för att lättare kunna navigera och se vad som händer när vi byter view.
     
    @Published var isSettingsViewActive = false {
        didSet {
            print("isSettingsViewActive \(isSettingsViewActive)")
        }
    }
    @Published var isTriviaViewActive = false {
        didSet {
            print("isTriviaViewActive \(isTriviaViewActive)")
        }
    }
    @Published var isScoreViewActive = false {
        didSet {
            print("isScoreViewActive \(isScoreViewActive)")
        }
    }
    @Published var isHighScoreViewActive = false {
        didSet {
            print("isHighScoreViewActive \(isHighScoreViewActive)")
        }
    }
    @Published var isAnswerViewActive = false {
        didSet {
            print("isAnswerViewActive \(isAnswerViewActive)")
        }
    }

    //Vår bas-URLsträng:
    let urlString = "https://opentdb.com/api.php"

    /**
     I denna func decodar vi vår API. decodeAPIResults tar emot en url, skapar upp en URLSession, en datatask och en JSONDecoder.
     */

    func decodeAPIResults(with url : URL)  {
        let session = URLSession(configuration: .default)
//1

        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil && data != nil {
                return
            }
//2
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                //3
                
//Här under decodar vi vår JSON object
                if let quizData = try? decoder.decode(QuizData.self, from: data!) {
                    self.quizData = quizData
                    self.quizResults = QuizResults()
               
                    
                    if quizData.responseCode == 1 {
                        self.responseCodeError = true
                    } else {
//För varje fråga i quizData.results binder vi en newQuestionObject till results arrayen
                        for questionObject in quizData.results {
                            let newQuestionObject = Question(questionData: questionObject)
                            self.quizResults?.results.append(newQuestionObject)
                        }
                        self.nextQuestion()
                        self.isTriviaViewActive = true
                    }
                }
            }
            //5
        }
        //4
        task.resume()
    }
    /**
     En funktion som bygger upp URL strängen baserat på den inställning som görs i SettingsView. När en setting har valts så läggs den till i vår urstrungs URL
     (rad 66).
     */
    func FetchTrivia(amount : Int, category : Int, difficulty : String) {
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
        print("URL:  \(url)")
        
        decodeAPIResults(with: url)
    }
    
    /**
     Denna funktion går igenom resultat-arrayen och för första objektet i arrayen sätter den in svaren i arrayen answerChoices och frågan i variabeln question. Timern startas också om.
     
     Detta händer för varje index när nextQuestion körs, fram till sista indexet, då tar spelet slut och ScoreView blir aktiv.
     */

    func nextQuestion() {
        guard let quizResults = quizResults else {
            return
        }
        if index < (quizResults.results.count) {
            self.answerChoices = quizResults.results[index].formattedAnswers
            self.question = quizResults.results[index].formattedQuestion
            index += 1
            if isTriviaViewActive {
                progressBarProgress = 0.0
            }
            
        } else {
            print("spelet är slut")
            isScoreViewActive = true
            isGameEnded = true
        }
    }

    /**
     Återställer alla inställningar till sina ursprungsvärden
     */

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
