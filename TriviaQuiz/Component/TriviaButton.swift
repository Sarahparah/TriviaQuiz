//
//  TriviaButton.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import UIKit
import SwiftUI

struct TriviaButton: View {
    
    var text: String
    var background: Color?

    @EnvironmentObject var triviaManager : TriviaManager

    var body: some View {
        
        Button(action: {
            
            print(text)
            
            if text == triviaManager.quizData?.results[triviaManager.index].correct_answer {
                triviaManager.score += 1
                print(triviaManager.score)
            }
            triviaManager.nextQuestion()
            
            // self.opacity(configuration.isPressed ? 0.7 : 1)
        }) {
            Text("\(text)")
                .foregroundColor(.white)
                .frame(width: 280, height: 50)
                .background(.blue.opacity(0.5))
                .cornerRadius(10)
               // .shadow(radius: 5)
               // .shadow(color: triviaManager.isGameEnded ? (.pink) : .gray, radius: 5, x: 0.5, y: 0.5)
        }
        .buttonStyle(MyButtonStyle())
    }
    
}

struct MyButtonStyle: ButtonStyle {
    @EnvironmentObject var triviaManager : TriviaManager

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(triviaManager.isGameEnded ? (LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)) : (LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)), in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
