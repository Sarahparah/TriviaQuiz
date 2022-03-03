//
//  SwiftUIView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-28.
//

import SwiftUI



struct ScoreView: View {
    
    @EnvironmentObject var triviaManager : TriviaManager
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                Text("Good job!")
                    .font(.system(size: 50))
                ZStack {
                    Circle()
                        .fill(.red)
                        .shadow(color: .white, radius: 5)
                    ZStack {
                    Circle()
                        .fill(.blue)
                        .padding(30)
                        .shadow(color: .white, radius: 5)
                    Text("Your score")
                        .font(.system(size: 40))
                        .padding(.bottom, 250)
                    }
                    Circle()
                        .fill(.yellow)
                        .padding(90)
                        .shadow(color: .white, radius: 5)
    
                        
                    Text("\(triviaManager.score)")
                        .font(.system(size: 120))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                }
                Text("out of \(triviaManager.numberOfQuestions) questions")
                    .font(.system(size: 50))
                Spacer()
                Button(action: {}) {
                    Text("See your answers")
                }
                NavigationLink(destination: FakeView()) {
                    Text("Fake View")
                }
                Spacer()
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
