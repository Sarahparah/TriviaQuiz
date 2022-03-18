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
    
    let categoriesArray = ["Mixed categories", "General knowledge", "Books", "Film", "Music", "Television", "Video Games", "Science & Nature", "Geography", "History", "Art", "Cartoons & Animations"]
    let difficultyArray = ["Mix", "Easy", "Medium", "Hard"]
    let numberOfQuestionsArray = [10, 20, 30, 40, 50]
    
    @State var selectedCategoryIndex = 0
    @State var selectedDifficultyIndex = 0
    @State var selectedNumberOfQuestions = 0

    var body: some View {
        
        ZStack {
            AnimatedBackground().edgesIgnoringSafeArea(.all)
                .blur(radius: 50)
            
            Circle().size(width: 1000, height: 1000)
                .fill(LinearGradient(colors: triviaManager.isColorMode ? [Color.blue, Color.white] : [.blue, .red],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .shadow(color: .white, radius: 10)
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
                        ForEach(0..<categoriesArray.count) {
                            Text("\(self.categoriesArray[$0])")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }.pickerStyle(WheelPickerStyle())
                }.offset(x: -70, y: 50)
                
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
                        ForEach(0..<difficultyArray.count) {
                            Text("\(self.difficultyArray[$0])")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }.pickerStyle(WheelPickerStyle())
                }.offset(x: -20, y: 20)
                
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
                        ForEach(0..<numberOfQuestionsArray.count) {
                            Text("\(self.numberOfQuestionsArray[$0])")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                .offset(x: 80, y: -20)
                
                Spacer()
                NavigationLink(destination: TriviaView(), isActive: $triviaManager.isTriviaViewActive) {
                    EmptyView()
                }.isDetailLink(false)
                Button(action: {
                    createGameFromSettings()
                    Sounds.playSounds(soundfile: "LetsDoThis.wav")
                }
                       , label: {
                    TextShimmer(text: "Let's do this!")
                        .foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                        .shadow(color: .black, radius: 3)
                })
                    .offset(y: -20)
                    .alert(isPresented: $triviaManager.responseCodeError) {
                        Alert(title: Text("Sorry!"), message: Text("We don't have \(numberOfQuestionsArray[selectedNumberOfQuestions]) \(difficultyArray[selectedDifficultyIndex].lowercased()) questions in the \(categoriesArray[selectedCategoryIndex].lowercased()) category"), primaryButton: .default(Text("OK")), secondaryButton: .cancel())
                    }
                    .navigationTitle("Customize your game")
            }
        }.onAppear {
            triviaManager.backToSettings = true
            Sounds.stopSounds()
        }
    }
    
    func createGameFromSettings() {
        triviaManager.resetGame()
        let numberOfQuestions = numberOfQuestionsArray[selectedNumberOfQuestions]
        triviaManager.numberOfQuestions = numberOfQuestions
        let difficulty = triviaManager.difficultyArray[selectedDifficultyIndex]
        let category = triviaManager.categoryNumbersArray[selectedCategoryIndex]
        
        triviaManager.FetchTrivia(amount: numberOfQuestions, category: category, difficulty: difficulty)
    }
}

struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}




