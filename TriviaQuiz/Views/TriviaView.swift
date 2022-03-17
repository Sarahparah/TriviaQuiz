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
    var currentGame = 0
    var isButtonPressed = false
    @State var countdownTimer: AVAudioPlayer?

    
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
