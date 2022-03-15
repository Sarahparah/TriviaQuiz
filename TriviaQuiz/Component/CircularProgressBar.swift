//
//  CircularProgressBar.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-03-11.
//

import SwiftUI

struct CircularProgressBar: View{

    @EnvironmentObject var triviaManager : TriviaManager

    var start = false

    var body: some View {

        VStack {
            
            ZStack {

                Circle()
                    .stroke(LinearGradient(colors: [.white, .blue], startPoint: .trailing, endPoint: .leading), lineWidth: 10)
                    .opacity(0.5)
                    .frame(width: 300, height: 300)

                Circle()
                    .trim(from: 0.0, to: triviaManager.progressBarProgress)
                    .stroke(LinearGradient(colors: triviaManager.isColorMode ? [.white] : [.orange, .green, .yellow],
                                           startPoint: .trailing,
                                           endPoint: .leading), lineWidth: 10)

                    .frame(width: 300, height: 300)
                    .rotationEffect(Angle(degrees: -90))

                    .blur(radius: 2.3) // Perfekt value ;^)
              
            }
            .onAppear(perform: {
                triviaManager.backToSettings = false
                startLoading()
                
            })
            

        }
    }
    
    func startLoading() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation() {
                triviaManager.progressBarProgress += 0.00333333333333
                if triviaManager.progressBarProgress >= 1.0 {
                    triviaManager.nextQuestion()
                    restartTimer()
                    
                }
                if triviaManager.isGameEnded {
                    timer.invalidate()
                }
                if triviaManager.backToSettings {
                    timer.invalidate()
                }
                
            }
        }
        
    }
    
    
    func restartTimer(){
        triviaManager.progressBarProgress = 0.0
    }
}


struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar()
    }
}
