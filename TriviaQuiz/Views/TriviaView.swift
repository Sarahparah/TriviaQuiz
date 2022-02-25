//
//  TriviaView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import SwiftUI

struct TriviaView : View {

    @EnvironmentObject var triviaManager : TriviaManager
    var currentGame = 0
    
    var body: some View {

        VStack{
            Spacer()
            Text(triviaManager.quizData?.results[0].question ?? "Error")
            
            Spacer()
            
            VStack{

                TriviaButton(text: triviaManager.quizData?.results[0].correct_answer ?? "Error")
                TriviaButton(text: triviaManager.quizData?.results[0].incorrect_answers[0] ?? "Error")
                TriviaButton(text: triviaManager.quizData?.results[0].incorrect_answers[1] ?? "Error")
                TriviaButton(text: triviaManager.quizData?.results[0].incorrect_answers[2] ?? "Error")
            }
            Spacer()
        }
        .navigationTitle("TriviaQuiz")
        .navigationBarItems(trailing: QuestionIndex())
    }
}

struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()

    }
}



