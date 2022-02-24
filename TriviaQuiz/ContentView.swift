//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {

        NavigationView {

            ZStack {

                LinearGradient(colors: [.red, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    HStack {

                    Text("TriviaQuiz")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .shadow(color: .black, radius: 2)
                        .padding()
                        Spacer()
                    }
                    NavigationLink(destination: TriviaView()) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    colors:
                                        [.red, .white],
                                    startPoint:
                                            .topLeading,
                                    endPoint:
                                            .bottomTrailing))
                                .shadow(color: .black, radius: 5)
                                .padding()

                            Button {

                            } label: {
                                Text("Enter game")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                        }.offset(y: -60)
                    }
                }
            }
            //.offset(y: -60)
            .navigationBarHidden(true)
            //.navigationTitle("TriviaQuiz").navigationViewStyle(NavigationViewStyle.)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
