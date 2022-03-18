//
//  TriviaView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import SwiftUI
import AVFoundation

struct TriviaView : View {
    
    @EnvironmentObject var triviaManager : TriviaManager
    let blueColorArray = [Color.blue, Color.white]
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .blue, .yellow],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    
                    Circle()
                        .fill(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.blue, .red],
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                    CircularProgressBar()
                        .offset(y:-5)
                    Text(triviaManager.question)
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                }
                .frame(width: 300, height: 300, alignment: .center)
                
                Spacer()
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    TriviaButton(answer: answer)
                }
                Spacer()
                
                NavigationLink(destination: ScoreView(), isActive: $triviaManager.isScoreViewActive) {EmptyView()}.isDetailLink(false)
            }
        }
        .navigationBarItems(trailing: QuestionIndex())
        .foregroundColor(.white)
    }
}

struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}
