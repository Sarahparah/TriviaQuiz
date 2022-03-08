//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    @State var animateGradient = false
    //@State var isColorMode = true
    let blueColorArray = [Color.blue, Color.white]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .yellow, .purple], startPoint: animateGradient ? .topLeading : .bottomTrailing, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                    .ignoresSafeArea()
                //                    .onAppear {
                //                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                //                            animateGradient.toggle()
                //                        }
                //                    }

                VStack {

                    ZStack {

                        Circle()
                            .fill(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .white],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .padding()

                        NavigationLink(destination: SettingsView()) {

                            ZStack{
                                Circle()
                                    .fill(triviaManager.isColorMode ? LinearGradient(colors: [.blue, .purple],
                                                                                     startPoint: .topLeading,
                                                                                     endPoint: .bottomTrailing) :
                                            LinearGradient(colors: [.red, .purple],
                                                           startPoint: .topLeading,
                                                           endPoint: .bottomTrailing))
                                    .padding(50)
                                    .shadow(color: .white, radius: 5)

                                Circle()
                                    .fill(triviaManager.isColorMode ? .blue : .yellow)
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
                    Button {
                        triviaManager.isColorMode.toggle()
                    } label: {
                        Text("Toggle ColorMode")
                    }.foregroundColor(.white)
                        //.frame(width: 160, height: 55)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .cyan] : [.purple, .pink],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))
                        .cornerRadius(30)


                }
            }
        }.environmentObject(triviaManager)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




