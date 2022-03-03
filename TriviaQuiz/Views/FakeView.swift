//
//  FakeView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-03.
//

import SwiftUI

struct FakeView: View {
    
    @StateObject var triviaManager = TriviaManager()
    @State var animateGradient = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.red, .yellow, .purple], startPoint: animateGradient ? .topLeading : .bottomTrailing, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
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
        }
        .environmentObject(triviaManager)
    }
}


struct FakeView_Previews: PreviewProvider {
    static var previews: some View {
        FakeView()
    }
}
