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
    let blueColorArray = [Color.blue, Color.white]
    var currentGame = 0
    var isButtonPressed = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .blue, .yellow],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            //            AnimatedBackground().edgesIgnoringSafeArea(.all)
            //                .blur(radius: 50)
            
            VStack{
                Text(triviaManager.question)
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(100)
                    .background(
                        Circle()
                        
                            .fill(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.blue, .red],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .frame(width: 310, alignment: .center)
                            .shadow(color: .white, radius: 10)
                        
                    )
                    .padding(.bottom, 40)
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    TriviaButton(answer: answer, buttonSelected: answer.isSelected)
                }
                //                        .offset(y: -10)
                
                NavigationLink(destination: ScoreView(), isActive: $triviaManager.isGameEnded) {EmptyView()}
                Spacer()
                
                HStack {
                    Button(action: {
                        if triviaManager.index >= 1 {
                            triviaManager.index -= 1
                        } else {
                            triviaManager.index = 0
                        }
                        triviaManager.nextQuestion()
                    }, label: {LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                                              startPoint: .top,
                                              endPoint: .bottom)
                            .frame(width: 50, height: 50)
                            .mask(Image(systemName: "arrow.left.circle"))
                            .font(.system(size: 50.0))
                            .padding(.leading, 20)
                        
                    })
                    Spacer()
                    Button(action: {
                        triviaManager.index += 1
                        triviaManager.nextQuestion()
                        
                    }, label: {
                        LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                            .frame(width: 50, height: 50)
                            .mask(Image(systemName: "arrow.right.circle"))
                            .font(.system(size: 50.0))
                            .padding(.trailing, 20)
                        
                    })
                }
            }
            
        }
        
        .navigationBarItems(trailing: QuestionIndex())
    }
}

struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}

//struct AnimatedBackground: View {
//    @State var start = UnitPoint(x: 0, y: -2)
//    @State var end = UnitPoint(x:4, y: 0)
//
//    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
//    let colors = [Color.blue, Color.red, Color.purple, Color.pink, Color.yellow,
//                  Color.green, Color.orange]
//    
//
//    var body: some View {
//        LinearGradient(gradient: Gradient(colors: colors), startPoint: start,
//                       endPoint: end)
//            .animation(Animation.easeInOut(duration: 6)
//                        .repeatForever()
//            ).onReceive(timer, perform: { _ in
//
//                self.start = UnitPoint(x: 4, y: 0)
//                self.end = UnitPoint(x: 0, y: 2)
//                self.start = UnitPoint(x:4, y: 20)
//                self.start = UnitPoint(x: 4, y: 0)
//            })
//    }
//}
