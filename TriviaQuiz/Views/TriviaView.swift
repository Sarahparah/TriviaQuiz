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
        
        ZStack {
            LinearGradient(colors: [.red, .blue, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(.yellow.opacity(0.8))
                        .frame(height: 280, alignment: .center)
                        .shadow(color: .white, radius: 5)
                        .padding()
                   // Text(triviaManager.quizData?.results[triviaManager.index].question ?? "Loading...")
                    Text(triviaManager.questionToDisplay)
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(50)
                }
                
                Spacer()
                
                VStack {
                    ForEach(triviaManager.allAnswers, id: \.self) {answer in
                        TriviaButton(text: answer)
                    }
                    
//                                    TriviaButton(text: triviaManager.allAnswers[0])
//                                    TriviaButton(text: triviaManager.allAnswers[1])
//                                    TriviaButton(text: triviaManager.allAnswers[2])
//                                    TriviaButton(text: triviaManager.allAnswers[3])
                    
//                    TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].correct_answer ?? "Loading...")
//                    TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].incorrect_answers[0] ?? "Loading...")
//                    TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].incorrect_answers[1] ?? "Loading...")
//                    TriviaButton(text: triviaManager.quizData?.results[triviaManager.index].incorrect_answers[2] ?? "Loading...")
                    
                }
                Spacer()
                NavigationLink(destination: ScoreView(), isActive: $triviaManager.isGameEnded) {EmptyView()}
                Spacer()
            }
        }
        .navigationTitle("TriviaQuiz")
        .navigationBarItems(trailing: QuestionIndex())
    }
}

struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}



