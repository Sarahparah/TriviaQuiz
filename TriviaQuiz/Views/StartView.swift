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
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        NavigationView {
            ZStack {
//                LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .yellow, .purple], startPoint: animateGradient ? .topLeading : .bottomTrailing, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
//                    .ignoresSafeArea()
                AnimatedBackgroundTwo().edgesIgnoringSafeArea(.all)
                    .blur(radius:50)
                
                VStack {
                    
                    ZStack {
// MARK: OUTER CIRCLE
                        
                        Circle()
                            .fill(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .white],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .padding()
                        NavigationLink(destination: SettingsView(), isActive: $triviaManager.isSettingsViewActive) {
                            EmptyView()
                        }.isDetailLink(false)
                        ZStack{
//MARK: INNER CIRCLE
                            
                            Circle()
                                .fill(triviaManager.isColorMode ? LinearGradient(colors: [.blue, .purple],
                                                                                 startPoint: .topLeading,
                                                                                 endPoint: .bottomTrailing) :
                                        LinearGradient(colors: [.red, .yellow, .pink],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing))
                                .padding(50)
                                .shadow(color: .white, radius: 5)
                            
                            Circle()
                                .fill(triviaManager.isColorMode ? LinearGradient(colors: [.blue, .teal, .orange],
                                                                                 startPoint: .topLeading,
                                                                                 endPoint: .bottomTrailing) :
                                        LinearGradient(colors: [.red, .purple],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing))
                                .padding(80)
                                .shadow(color: .white, radius: 5)
                            
//MARK: LOGO IMAGE
                            Image("180")
                                .mask(Circle()
                                        .frame(width: 200, alignment: .center))
                                .shadow(color: .white, radius: 5)
     
                        }
                        .onTapGesture {
                            triviaManager.isSettingsViewActive = true
                        }
                        // }
                    }
                    .offset(y: -60)
                    .navigationTitle("TriviaQuiz")
                    Button {
                        triviaManager.isColorMode.toggle()
                        // triviaManager.colorMode = ColorMode(context: viewContext)
                        // triviaManager.colorMode.color = triviaManager.isColorMode
                        // triviaManager.isColorMode = colorMode.color
                        //                        let newItem = ColorMode(context: viewContext)
                        //                        print(newItem.color)
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
        }
        .environmentObject(triviaManager)
            .navigationViewStyle(.stack)
    }
  
}






