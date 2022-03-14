//
//  CircularProgressBar.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-03-11.
//

import SwiftUI

struct CircularProgressBar: View{
    
    
    @EnvironmentObject var triviaManager : TriviaManager
    
     //var circleProgress : CGFloat = triviaManager.progressBarProgress
    
    var start = false
    
    
//    init() {
//
//        @State var circleProgress : CGFloat = triviaManager.progressBarProgress
//
//    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(LinearGradient(colors: [.blue, .white], startPoint: .trailing, endPoint: .leading), lineWidth: 10)
                    .frame(width: 300, height: 300)
                Circle()
                    .trim(from: 0.0, to: triviaManager.progressBarProgress)
                    .stroke(Color.red, lineWidth: 10)
                    .frame(width: 300, height: 300)
                    .rotationEffect(Angle(degrees: -90))
                    .blur(radius: 1)

                
            }
            .onAppear(perform: startLoading)
//            Button(action: {self.startLoading()}) {
//                Text("start timer")
                
            
            
        }
    }
    
    
    func startLoading() {
        
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                withAnimation() {
                    triviaManager.progressBarProgress += 0.01
                    if triviaManager.progressBarProgress >= 1.0 {
                        triviaManager.nextQuestion()
                        restartTimer()
                        
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
