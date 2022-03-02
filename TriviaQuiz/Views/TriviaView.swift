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
    var allAnswers : [String] = []
    
    var body: some View {

        VStack{
            Spacer()
            Text(triviaManager.quizData?.results[triviaManager.index].question ?? "Loading...")
            
            Spacer()
            
            VStack {

                TriviaButton(text: triviaManager.allAnswers[0] ?? "Loading")
                TriviaButton(text: triviaManager.allAnswers[1] ?? "Loading")
                TriviaButton(text: triviaManager.allAnswers[2] ?? "Loading")
                TriviaButton(text: triviaManager.allAnswers[3] ?? "Loading")
//                TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].correct_answer ?? "Loading...")
//                TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].incorrect_answers[0] ?? "Loading...")
//                TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].incorrect_answers[1] ?? "Loading...")
//                TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].incorrect_answers[2] ?? "Loading...")
                
            }
            Spacer()
            NavigationLink(destination: ScoreView(), isActive: $triviaManager.isGameEnded) {EmptyView()}
            Spacer()
        }
        .navigationTitle("TriviaQuiz")
        .navigationBarItems(trailing: QuestionIndex())
//        .onAppear {
//            allAnswers = QuestionData.createAllAnswersArray()
//            var allAnswers : [String] = []
//            allAnswers[0] = triviaManager.quizData?.results[triviaManager.index].incorrect_answers[0] ?? "Loading..."
//            allAnswers.append(triviaManager.quizData?.results[triviaManager.index].correct_answer ?? "")
//            allAnswers.shuffle()
//            print("All answers: \(allAnswers)")
//        }
    }
}

struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()

    }
}



