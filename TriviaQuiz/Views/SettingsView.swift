//
//  SettingsView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-24.
//

import Foundation
import SwiftUI

struct SettingsView : View {
    
    @EnvironmentObject var triviaManager : TriviaManager
    @State var animateGradient = false

    
    let categories = ["General knowledge", "Books", "Film", "Music", "Television", "Video Games", "Science & Nature", "Geography", "History", "Art", "Cartoons & Animations"]
    let color = [Color.green, Color.yellow, Color.blue, Color.red, Color.purple, Color.pink]
    let difficulty = ["easy", "medium", "hard"]
    let numberOfQuestions = [10, 20, 30, 40, 50]
    
    @State var selectedCategoryIndex = 0
    @State var selectedDifficultyIndex = 0
    @State var selectedNumberOfQuestions = 0
    @State var isTriviaViewActive = false

    let blueColorArray = [Color.blue, Color.white]
    let defaultColorArray = [Color.blue, Color.yellow, Color.purple]
//    let contentView = ContentView()
    
    let circleSize = CGSize(width: 1000, height: 1000)
    
    var body: some View {
        
        ZStack {
//            LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : defaultColorArray,
//                           startPoint: .topLeading,
//                           endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            AnimatedBackground().edgesIgnoringSafeArea(.all)
                .blur(radius: 50)
            
            
            Circle().size(circleSize)
                .fill(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.blue, .red],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .shadow(color: .white, radius: 5)
                .padding(.top, 50)
                
            VStack {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.purple, .blue, Color.purple.opacity(0.5), .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 5)
                    Text("Category")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, 90)
                        .foregroundColor(.yellow)
                    Picker(selection: $selectedCategoryIndex, label: Text("")) {
                        ForEach(0..<categories.count) {
                            Text("\(self.categories[$0])")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                .offset(x: -70, y: 50)
                
                // }.position(x: 130, y: 160)
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 5)
                    Text("Difficulty")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, 90)
                        .foregroundColor(.yellow)
                    Picker(selection: $selectedDifficultyIndex, label: Text("")) {
                        ForEach(0..<difficulty.count) {
                            Text("\(self.difficulty[$0])")
                                .foregroundColor(.white)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
                }.offset(x: -20, y: 20)
                //.position(x: 195, y: 150)
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.blue, Color.yellow.opacity(0.5), .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 10)
                    
                    Circle()
                        .fill(LinearGradient(colors: [.yellow, .blue, .purple], startPoint: .topTrailing, endPoint: .bottomLeading))
                        .padding()
                        .shadow(color: .white, radius: 5)
                    Text("Questions")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, 90)
                        .foregroundColor(.yellow)
                    Picker(selection: $selectedNumberOfQuestions, label: Text("")) {
                        ForEach(0..<numberOfQuestions.count) {
                            Text("\(self.numberOfQuestions[$0])")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
                }
                .offset(x: 80, y: -20)
                //.position(x: 260, y: 110)
                
                Spacer()
                NavigationLink(destination: TriviaView(), isActive: $isTriviaViewActive) {
                    EmptyView()
                }
                Button(action: {
                    isTriviaViewActive = true
                    
                    triviaManager.numberOfQuestions = numberOfQuestions[selectedNumberOfQuestions]
                    
                    triviaManager.difficulty = difficulty[selectedDifficultyIndex]
                    
                    triviaManager.category = triviaManager.categoryNumbersArray[selectedCategoryIndex]
                    
                    triviaManager.fetchTheFetchTrivia(amount: triviaManager.numberOfQuestions, category: triviaManager.category, difficulty: triviaManager.difficulty)
                    returnSettings()
                    
                }, label: {
                    Text("Let's quiz!")
                        .foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                })
                    .offset(y: -20)
            }
            
            .navigationTitle("Customize your game")
            //.cornerRadius(10)
            //.edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func returnSettings() {
        
        triviaManager.numberOfQuestions = Int(numberOfQuestions[selectedNumberOfQuestions])
        
    }
}


struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x:4, y: 0)

    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
//    let colors = [Color.blue, Color.red, Color.purple, Color.pink, Color.yellow,
//                  Color.green, Color.orange]
    let colors = [Color.blue, Color.white, Color.purple]

    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start,
                       endPoint: end)
            .animation(Animation.easeInOut(duration: 6)
                        .repeatForever()
            ).onReceive(timer, perform: { _ in

                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x:4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}
