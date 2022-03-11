//
//  CircularProgressBar.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-03-11.
//

import SwiftUI

struct CircularProgressBar: View {
    
    @State var circleProgress : CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(LinearGradient(colors: [.blue, .clear], startPoint: .trailing, endPoint: .leading), lineWidth: 15)
                    .frame(width: 300, height: 300)
                Circle()
                    .trim(from: 0.0, to: circleProgress)
                    .stroke(Color.white, lineWidth: 15)
                    .frame(width: 300, height: 300)
                    .rotationEffect(Angle(degrees: -90))

                
            }
            Button(action: {self.startLoading()}) {
                Text("start timer")
            }
            
        }
    }
    
    
    func startLoading() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation() {
                self.circleProgress += 0.01
                if self.circleProgress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
        
    }
}


struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar()
    }
}
