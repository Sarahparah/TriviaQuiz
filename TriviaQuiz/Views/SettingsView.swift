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
    
    let categorys = ["History", "Entertainment: books", "General knowledge", "Entertainment: Cartoons&Animations", "Science&Nature", "Geography"]
    
    let color = [Color.green, Color.yellow, Color.blue, Color.red, Color.purple, Color.pink]
    
    let difficulty = ["easy", "medium", "hard"]
    
    //let numberOfQuestions = ["10", "20", "30", "40", "50"]
    let numberOfQuestions = [10, 20, 30, 40, 50]
    
    @State var selectedCategoryIndex = 0
    @State var selectedDifficultyIndex = 0
    @State var selectedNumberOfQuestions = 0
    @State var isTriviaViewActive = false
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue, Color.yellow.opacity(0.5)], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                //PickerStack(array: categorys, title: "category", index: selectedCategoryIndex)
                Picker(selection: $selectedCategoryIndex, label: Text("")) {
                    ForEach(0..<categorys.count) {
                        Text("\(self.categorys[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Spacer()
                //PickerStack(array: difficulty, title: "difficulty", index: selectedDifficultyIndex)
                Picker(selection: $selectedDifficultyIndex, label: Text("")) {
                    ForEach(0..<difficulty.count) {
                        Text("\(self.difficulty[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Spacer()
                //PickerStack(array: triviaManager.numberOfQuestionsArray, title: "number of questions", index: selectedNumberOfQuestions)
                Picker(selection: $selectedNumberOfQuestions, label: Text("")) {
                    ForEach(0..<numberOfQuestions.count) {
                        Text("\(self.numberOfQuestions[$0])")

                    }
                }.pickerStyle(SegmentedPickerStyle())

                Spacer()
                NavigationLink(destination: TriviaView(), isActive: $isTriviaViewActive) {
                    EmptyView()
                }
                Button(action: {
                    isTriviaViewActive = true

                    triviaManager.numberOfQuestions = numberOfQuestions[selectedNumberOfQuestions]

                    triviaManager.difficulty = difficulty[selectedDifficultyIndex]

                    //triviaManager.category = categorys[selectedCategoryIndex]

                    triviaManager.category = selectedCategoryIndex
                    
                    triviaManager.fetchTheFetchTrivia(amount: triviaManager.numberOfQuestions, category: triviaManager.category, difficulty: triviaManager.difficulty)
                    print("selectedCategoryIndex: \(selectedCategoryIndex)")  //GREAT SUCCESS!
                    print("selectedNumberOfQuestions: \(numberOfQuestions[selectedNumberOfQuestions])")
                    returnSettings()
                    print("triviaManagers numberOfQuestions variabel: \(triviaManager.numberOfQuestions)!")
                    print("Current urlString: \(triviaManager.urlString)!")
                }, label: {
                    Text("START YOUR GAME")
                })
            }
            .navigationTitle("Customize your game")
            .frame(width: 300, height: 600, alignment: .center)
            .background(.teal)
            .cornerRadius(10)
        }
    }


    func returnSettings() {

        triviaManager.numberOfQuestions = Int(numberOfQuestions[selectedNumberOfQuestions])

    }
}

//
//struct SettingsViewPreviews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
