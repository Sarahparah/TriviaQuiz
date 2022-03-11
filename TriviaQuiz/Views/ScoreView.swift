//
//  SwiftUIView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-28.
//

import SwiftUI



struct ScoreView: View {
    
    var randomWords = ["Good job", "Almost there", "Score!"]
    @EnvironmentObject var triviaManager : TriviaManager
    

    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.white, .yellow], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                Text("\(randomWords[1])")
                    .font(.system(size: 50))
                ZStack {
                    Capsule()
                        .fill(LinearGradient(colors: [.green, .teal], startPoint: .center, endPoint: .bottom))
                        .shadow(color: .white, radius: 40)
                        .padding(10)
                        //.rotationEffect(.init(degrees: 30))
                    ZStack {
                    Capsule()
                        .fill(.white)
                        .padding(30)
                        .shadow(color: .white, radius: 5)
                    Text("Your score")
                        .font(.system(size: 40))
                        .padding(.bottom, 250)
                    }
                    Circle()
                        .fill(.black)
                        .padding(90)
                        .shadow(color: .white, radius: 5)
    
                    Text("\(triviaManager.score)")
                        .font(.system(size: 180))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .blur(radius: 15.0)
                    
                    Text("\(triviaManager.score)")
                        .font(.system(size: 180))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Text("out of \(triviaManager.numberOfQuestions)")
                    .font(.system(size: 50))
                Spacer()
//                NavigationLink(destination: TriviaView(), isActive: $triviaManager.isTriviaViewActive) {
//                    EmptyView()
//                }
//                NavigationLink(destination: SettingsView(), isActive: $isSettingsViewActive) {
//                    EmptyView()
//                }
                Button(action: {
                    triviaManager.isScoreViewActive = false
                    triviaManager.isTriviaViewActive = false
                    triviaManager.index = 0
                    triviaManager.nextQuestion()
                    
                },
                       label: {
                    Text("See your answers")
                })
                Button(action: {
                    triviaManager.isScoreViewActive = false
                    triviaManager.isTriviaViewActive = false
                    triviaManager.resetGame()
                }, label: {Text("Play again")})
                
                NavigationLink(destination: FakeView()) {
                    Text("Fake View")
                }
               // Spacer()
            }
        }.navigationBarBackButtonHidden(true)
        
    }
    
}








struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .environmentObject(TriviaManager())
    }
}
