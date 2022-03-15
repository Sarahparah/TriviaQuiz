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
   // @State var buttonSelected: Bool
    
    
    @EnvironmentObject var triviaManager : TriviaManager
   // @State private var didTap: Bool = false
    
    var body: some View {
        
        Button(action: {
           // self.didTap = true
            print(answer.text)
            
            if !triviaManager.isAnswerViewActive {
            if answer.isCorrect {
                triviaManager.score += 1
                print("Current score: \(triviaManager.score)")
            } else {
                print("Wrong answer!")
            }
            triviaManager.selectAnswer(answer: answer)
                answer.isSelected = true
               // print("isSelected: \(answer.text)\(answer.isSelected)")
            }
            triviaManager.nextQuestion()
            
        }) {
            Text("\(answer.text)")
            // .foregroundColor(.white)
            //    .foregroundColor(.white)
                .frame(width: 280, height: 50)
                .background(.blue.opacity(0.5))
                .cornerRadius(10)
                .multilineTextAlignment(.center)
        }
        .onAppear{
            print("is selected: \(answer.text) \(answer.isSelected)")
                  
                  }
        .onTapGesture {
            if !triviaManager.answerSelected {
               // didTap = true
               // answer.isSelected = true
            }
        }
        .buttonStyle(MyButtonStyle(answer: answer))
    }
    
}

struct MyButtonStyle: ButtonStyle {
    @EnvironmentObject var triviaManager : TriviaManager
    
    let blueColorArray = [Color.blue, Color.white]
    var answer: Answer
   // var didTap : Bool
    var isButtonPressed = false
    
    
    func makeBody(configuration: Configuration) -> some View {
        
            
        if triviaManager.isAnswerViewActive {
            configuration.label
                .padding(5)
                .background(answer.isCorrect ? (LinearGradient(colors: [.green, .white], startPoint: .topLeading, endPoint: .bottomTrailing)) : (LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)), in: Capsule())
                .foregroundColor(answer.isSelected ? .black : .white)
        } else {
            configuration.label
                .padding(5)
            .background(triviaManager.isGameEnded ? (LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)) : (LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)), in: Capsule())
            .foregroundColor(.white)
        }
          
           // .opacity(self.didTap ? 0.2 : 1)
        
    }
    
}

struct TriviaButton_Previews: PreviewProvider {
    
    static var previews: some View {
        TriviaButton(answer: Answer(text: "Single", isCorrect: false, isSelected: false))
    }
}
