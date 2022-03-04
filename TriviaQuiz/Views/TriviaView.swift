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
                        .fill(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 280, alignment: .center)
                        .shadow(color: .white, radius: 5)
                        .padding()
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
