//
//  AnswerView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-14.
//

import SwiftUI

struct AnswerView : View {
    
    @EnvironmentObject var triviaManager : TriviaManager
    let blueColorArray = [Color.blue, Color.white]
    @State var nextAnswerButtonIsDisabled = false
    
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
                    
                    Text(triviaManager.question)
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                }
                .frame(width: 300, height: 300, alignment: .center)
                
                Spacer()
                HStack {
                    Button(action: {
                        triviaManager.nextQuestion()
                        if triviaManager.index >= triviaManager.numberOfQuestions {
                            nextAnswerButtonIsDisabled = true
                        }
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                            .frame(width: 50, height: 50)
                            .mask(Image(systemName: "arrow.right.circle"))
                            .font(.system(size: 50.0))
                            .padding(.trailing, 20)
                    })
                        .disabled(nextAnswerButtonIsDisabled)
                        .opacity(nextAnswerButtonIsDisabled ? 0.1 : 1.0)
                }
                Spacer()
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    TriviaButton(answer: answer)
                        .disabled(true)
                }
                Spacer()
            }.onAppear{
                triviaManager.nextQuestion()
            }
        }
        .navigationBarItems(trailing: QuestionIndex())
    }
}

struct AnswerViewPreviews: PreviewProvider {
    static var previews: some View {
        AnswerView()
            .environmentObject(TriviaManager())
    }
}
