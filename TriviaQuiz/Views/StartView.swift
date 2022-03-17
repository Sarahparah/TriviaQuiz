//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    @State var animateGradient = false
    let blueColorArray = [Color.blue, Color.white]
   // @State var countdownTimer: AVAudioPlayer?
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        NavigationView {
            ZStack {
                AnimatedBackgroundTwo().edgesIgnoringSafeArea(.all)

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
                            //self.countdownTimer?.play()
                           // self.isPlaying.toggle()
                            Sounds.playSounds(soundfile: "startButton.wav")
                        }
                    }
                    .offset(y: -60)
                    //.navigationTitle("TriviaQuiz")
                    Button {
                        triviaManager.isColorMode.toggle()
                        Sounds.playSounds(soundfile: triviaManager.isColorMode ? "LetsDoThis.wav" : "koolbackground.mp3")
                    } label: {
                       // Text("Toggle ColorMode")
                        TextShimmer(text: "Color mode")
                    }.foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .cyan] : [.purple, .pink],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))
                        .cornerRadius(30)
                        .shadow(color: .black, radius: 3)
                }
            }
            .onAppear {
                Sounds.playSounds(soundfile: triviaManager.isColorMode ? "LetsDoThis.wav" : "koolbackground.mp3")

//                let sound = Bundle.main.path(forResource: "startButton", ofType: "wav")
//                self.countdownTimer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            }
        }
        .environmentObject(triviaManager)
            .navigationViewStyle(.stack)
    }
}
//struct player {
//    let path = Bundle.main.path(forResource: "startButton.wav", ofType:nil)!
//    let url = URL(fileURLWithPath: path)
//
//    do {
//        countdownTimer = try AVAudioPlayer(contentsOf: url)
//        countdownTimer?.play()
//    } catch {
//        // couldn't load file 😦
//    }
//}
