//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()  //skapar upp triviaManagerobjekt (stateObject) så vi kan komma åt variablerna där!
    @State var animateGradient = false

    @Environment(\.managedObjectContext) private var viewContext // coreData relaterad, injicerar managedObjectContext in i swiftUi-miljön
    
    var body: some View {
        
        NavigationView {
            ZStack { 
                AnimatedBackgroundTwo().edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        
// MARK: -OUTER CIRCLE
                        Circle()
                            .fill(LinearGradient(colors: triviaManager.isColorMode ? [Color.blue, Color.white] : [.red, .white],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .padding()
                        
                        StartGameCircle()
                            .onTapGesture {
                                triviaManager.isSettingsViewActive = true
                                Sounds.playSounds(soundfile: "startButton.wav")
                            }
                    }
                    .offset(y: -60)
                    ToggleColorButton()
                    NavigationLink(destination: SettingsView(), isActive: $triviaManager.isSettingsViewActive) {
                        EmptyView()
                    }.isDetailLink(false)
                }
            }
            .onAppear {
                Sounds.playSounds(soundfile: triviaManager.isColorMode ? "desertSound.mp3" : "koolbackground.mp3")
            }
        }
        .environmentObject(triviaManager)
        .navigationViewStyle(.stack)
    }
}

struct ToggleColorButton : View {
    @EnvironmentObject var triviaManager : TriviaManager
    
    var body: some View {
        Button {
            triviaManager.isColorMode.toggle()
            Sounds.playSounds(soundfile: triviaManager.isColorMode ? "desertSound.mp3" : "koolbackground.mp3")
        } label: {
            TextShimmer(text: "Color mode")
        }
        .foregroundColor(.white)
        .frame(width: 220, height: 50)
        .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .cyan] : [.purple, .pink],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .cornerRadius(30)
        .shadow(color: .black, radius: 3)
    }
}

struct StartGameCircle : View {
    @EnvironmentObject var triviaManager : TriviaManager
    
    var body: some View {
        ZStack{
            
//MARK: -INNER CIRCLE
            Circle()
                .fill(triviaManager.isColorMode ? LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing) :
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
            
//MARK: -LOGO IMAGE

            Image("180")
                .mask(Circle()
                        .frame(width: 200, alignment: .center))
                .shadow(color: .white, radius: 5)
            
        }
    }
}
