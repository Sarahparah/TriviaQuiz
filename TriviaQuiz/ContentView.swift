//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
            
                LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ZStack{
                                    
                Circle()
                    //.fill(.black)
                        .fill(LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding()
                    
                NavigationLink(destination: TriviaView()) {
                    
                    Text("Enter game")
                        .foregroundColor(.white)
                        .font(.title)
                }
                }
                .offset(y: -60)
                .navigationTitle("TriviaQuiz")
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
