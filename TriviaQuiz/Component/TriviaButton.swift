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
    @State private var didTap: Bool = false

    var body: some View {
        
        Button(action: {
            self.didTap = true
            print(text)
            
            if text == triviaManager.quizData?.results[triviaManager.index].correct_answer {
                triviaManager.score += 1
                print(triviaManager.score)
            }
           // triviaManager.nextQuestion(backwards: triviaManager.backwards)
            
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
        .buttonStyle(MyButtonStyle(didTap: self.didTap))
    }
    
}

struct MyButtonStyle: ButtonStyle {
    @EnvironmentObject var triviaManager : TriviaManager

    let blueColorArray = [Color.blue, Color.white]

    var didTap : Bool


    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()

            .background(triviaManager.isGameEnded ? (LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .white],
                                                                    startPoint: .topLeading,
                                                                    endPoint: .bottomTrailing))
                        : (LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .yellow, .purple],
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)), in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)

            .background(triviaManager.isGameEnded ? (LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)) : (LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)), in: Capsule())
           // .opacity(configuration.isPressed ? 0.5 : 1)
            .opacity(self.didTap ? 0.2 : 1)

    }
}
