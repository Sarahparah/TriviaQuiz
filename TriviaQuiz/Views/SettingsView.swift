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
    
    let categories = ["General knowledge", "Books", "Film", "Music", "Television", "Video Games", "Science & Nature", "Geography", "History", "Art", "Cartoons & Animations"]
    let color = [Color.green, Color.yellow, Color.blue, Color.red, Color.purple, Color.pink]
    let difficulty = ["easy", "medium", "hard"]
    let numberOfQuestions = [10, 20, 30, 40, 50]
    
    @State var selectedCategoryIndex = 0
    @State var selectedDifficultyIndex = 0
    @State var selectedNumberOfQuestions = 0
    @State var isTriviaViewActive = false
    
    let circleSize = CGSize(width: 1000, height: 1000)
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                //PickerStack(array: categorys, title: "category", index: selectedCategoryIndex)
                
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.purple, .blue, Color.purple.opacity(0.5), .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 5)

                    Circle().size(circleSize)
                        .fill(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 5)
                        .edgesIgnoringSafeArea(.all)
                        .padding(.top, 50)
                    ZStack {
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
                }.position(x: 130, y: 160)
                
                Spacer()
                //PickerStack(array: difficulty, title: "difficulty", index: selectedDifficultyIndex)
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 5)
                        
                    ZStack {
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
                    }
                }.position(x: 195, y: 150)
                
                Spacer()
                //PickerStack(array: triviaManager.numberOfQuestionsArray, title: "number of questions", index: selectedNumberOfQuestions)
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.blue, Color.yellow.opacity(0.5), .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 10)

                    Circle()
                        .fill(LinearGradient(colors: [.yellow, .blue, .purple], startPoint: .topTrailing, endPoint: .bottomLeading))
                        .padding()
                        .shadow(color: .white, radius: 5)

                    ZStack {
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
                }.position(x: 260, y: 110)
                
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
                   // print("selectedCategoryIndex: \(selectedCategoryIndex)")  //GREAT SUCCESS!
                   // print("selectedNumberOfQuestions: \(numberOfQuestions[selectedNumberOfQuestions])")
                    returnSettings()
                   // print("triviaManagers numberOfQuestions variabel: \(triviaManager.numberOfQuestions)!")
                   // print("Current urlString: \(triviaManager.urlString)!")
                    
                }, label: {
                    Text("Let's quiz!")
                        .foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                })
            }
            .navigationTitle("Customize your game")
            .cornerRadius(10)
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
