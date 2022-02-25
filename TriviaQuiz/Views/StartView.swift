//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
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
        }.environmentObject(triviaManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
