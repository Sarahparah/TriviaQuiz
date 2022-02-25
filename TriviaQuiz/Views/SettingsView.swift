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
    
    let difficulty = ["Easy", "Medium", "Hard"]
    
    //let numberOfQuestions = ["10", "20", "30", "40", "50"]
    
    @State var selectedCategoryIndex = 0
    @State var selectedDifficultyIndex = 0
    @State var selectedNumberOfQuestions = 0
    @State var isTriviaViewActive = false
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue, Color.yellow.opacity(0.5)], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack{
                
                Spacer()
                PickerStack(array: categorys, title: "category", index: selectedCategoryIndex)
                Spacer()
                PickerStack(array: difficulty, title: "difficulty", index: selectedDifficultyIndex)
                Spacer()
                PickerStack(array: triviaManager.numberOfQuestions, title: "number of questions", index: selectedNumberOfQuestions)
                Spacer()
                NavigationLink(destination: TriviaView(), isActive: $isTriviaViewActive) {
                    EmptyView()
                }
                Button(action: {
                    triviaManager.fetchTrivia()
                    isTriviaViewActive = true
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
}

struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
