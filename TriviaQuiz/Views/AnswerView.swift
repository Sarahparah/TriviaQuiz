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
    var currentGame = 0
    var isButtonPressed = false
    @State var previousAnswerButtonIsDisabled = false
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
                                    if triviaManager.index >= 1 {
                                        triviaManager.index -= 1
                                        previousAnswerButtonIsDisabled = false
                                    } else {
                                        triviaManager.index = 0
                                        previousAnswerButtonIsDisabled = true
                                    }
                                    triviaManager.nextQuestion()
                                }, label: {LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                                                          startPoint: .top,
                                                          endPoint: .bottom)
                                        .frame(width: 50, height: 50)
                                        .mask(Image(systemName: "arrow.left.circle"))
                                        .font(.system(size: 50.0))
                                        .padding(.leading, 20)
                                    
                //                        .offset(x:40)
                                })
                        .disabled(previousAnswerButtonIsDisabled)
                                Spacer()
                                Button(action: {
                                   // triviaManager.index += 1
                                    triviaManager.nextQuestion()
                                    
                                }, label: {
                                    LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                                                   startPoint: .top,
                                                   endPoint: .bottom)
                                        .frame(width: 50, height: 50)
                                        .mask(Image(systemName: "arrow.right.circle"))
                                        .font(.system(size: 50.0))
                                        .padding(.trailing, 20)
                                        
                //                        .offset(x:40)
                                })
                            }
                Spacer()
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    TriviaButton(answer: answer, buttonSelected: answer.isSelected)
                }
                Spacer()
                
               // NavigationLink(destination: ScoreView(), isActive: $triviaManager.isScoreViewActive) {EmptyView()}.isDetailLink(false)
            }.onAppear(perform: triviaManager.nextQuestion)
        }
        .navigationBarItems(trailing: QuestionIndex())
    }
}

//struct AnswerViewPreviews: PreviewProvider {
//    static var previews: some View {
//        AnswerView()
//            .environmentObject(TriviaManager())
//    }
//}
