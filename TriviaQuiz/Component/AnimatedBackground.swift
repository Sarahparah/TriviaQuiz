//
//  AnimatedBackground.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-15.
//

import SwiftUI

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x:4, y: 0)
    @EnvironmentObject var triviaManager : TriviaManager

    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors2 = [Color.blue, Color.purple, Color.yellow]
    let colors = [Color.purple, Color.blue, Color.white]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: triviaManager.isColorMode ? colors : colors2), startPoint: start,
                       endPoint: end)
            .animation(Animation.easeInOut(duration: 3)
                        .repeatForever()
            ).onReceive(timer, perform: { _ in
                
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x:4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}

struct AnimatedBackgroundTwo: View {

    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x:4, y: 0)
    let colors2 = [Color.blue, Color.purple, Color.yellow]
    let colors = [Color.purple, Color.blue, Color.blue, Color.white]
    @EnvironmentObject var triviaManager : TriviaManager
    
    @State var isAnimating = false {
        didSet {
            print("anim \(isAnimating)")
        }
    }
    var body: some View {
        LinearGradient(gradient: Gradient(colors: triviaManager.isColorMode ? colors : colors2), startPoint: start,
                       endPoint: end)

            .animation(
                Animation.easeInOut(duration: 3).repeatForever(),   //Frame Size startar på 0 när gränssnittet initieras pga navigationview
                value: start // och animationen kickar igång direkt, vilket resulterar i att det animeras när storleken på vyerna sätts
            )
            .onAppear {
                print("onappear")
                DispatchQueue.main.async {
                    self.start = UnitPoint(x: 4, y: 0)
                    self.end = UnitPoint(x: 0, y: 2)
                }
            }
    }
}
