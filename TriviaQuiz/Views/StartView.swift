//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    @State var scale: CGFloat = 1
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                //  LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                AnimatedBackground()
                    .scaleEffect(1.5)
                //.ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 50)
                ZStack{
                    Circle()
                        .fill(LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding()
                    
                    NavigationLink(destination: SettingsView()) {
                        
                        ZStack{
                            Circle()
                                .fill(.blue)
                                .padding(50)
                                .shadow(color: .white, radius: 5)
//                                .scaleEffect(scale)
//                                .onAppear {
//                                    let baseAnimation =
//                                    Animation.easeInOut(duration: 1)
//                                    let repeated = baseAnimation.repeatForever(autoreverses: true)
//
//                                    withAnimation(repeated) {
//                                        scale = 0.5
//                                    }
//                                }
                            Circle()
                                .fill(.yellow)
                                .padding(110)
                                .shadow(color: .white, radius: 5)
                            Text("Enter game")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                        }
                    }
                }
                .offset(y: -60)
                .navigationTitle("TriviaQuiz")
            }
        }.environmentObject(triviaManager)
    }
}

struct AnimatedBackground: View {
    
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.red, Color.purple, Color.pink, Color.yellow, Color.green, Color.orange]
    
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 6)
                        .repeatForever()
            ).onReceive(timer, perform: { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
