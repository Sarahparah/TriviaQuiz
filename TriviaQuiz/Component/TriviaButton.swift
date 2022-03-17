//
//  TriviaButton.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import UIKit
import SwiftUI

struct TriviaButton: View{
    
    var background: Color?
    @State var answer: Answer
    @EnvironmentObject var triviaManager : TriviaManager
    
    var body: some View {
        Button(action: {
            print(answer.text)
            if !triviaManager.isAnswerViewActive {
                if answer.isCorrect {
                    triviaManager.score += 1
                    print("Current score: \(triviaManager.score)")
                } else {
                    print("Wrong answer!")
                }
                answer.isSelected = true
            }
            triviaManager.nextQuestion()
            
        }) {
            Text("\(answer.text)")
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .frame(width: 280, height: 50)
                .background(.blue.opacity(0.5))
                .cornerRadius(10)
                .multilineTextAlignment(.center)
        }
        .buttonStyle(MyButtonStyle(answer: answer))
    }
}

struct MyButtonStyle: ButtonStyle {
    @EnvironmentObject var triviaManager : TriviaManager
    let blueColorArray = [Color.blue, Color.white]
    var answer: Answer
    func makeBody(configuration: Configuration) -> some View {
        
        if triviaManager.isAnswerViewActive {
            configuration.label
                .foregroundColor(.white)
                .padding(5)
                .background(answer.isCorrect ? (LinearGradient(colors: [.green, .white, .green], startPoint: .topLeading, endPoint: .bottomTrailing)) : (LinearGradient(colors: [.red, .white, .red], startPoint: .topLeading, endPoint: .bottomTrailing)), in: RoundedRectangle(cornerRadius: 30))
                .opacity(answer.isCorrect ? 1 : 0.5)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(answer.isSelected ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 2))
                )
                .shadow(color: .white, radius: 10)
        } else {
            configuration.label
                .padding(5)
                .background(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), in: Capsule())
                .foregroundColor(.white)
        }
    }
}

struct TriviaButton_Previews: PreviewProvider {
    
    static var previews: some View {
        TriviaButton(answer: Answer(text: "Single", isCorrect: false))
    }
}
