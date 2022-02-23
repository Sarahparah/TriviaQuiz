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
                
                
                Color
                    .red
                    .ignoresSafeArea()
                ZStack{
                                    
                Circle()
                    .fill(.black)
                    .padding()
                    
        
                
                NavigationLink(destination: TriviaView()) {
                    
                    Text("Enter game")
                        .foregroundColor(.white)
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
