//
//  TriviaView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import SwiftUI

struct TriviaView : View {

    var triviaManager = TriviaManager()
    //var settingsView = settingsView()
    var currentGame = 0 
    
    var body: some View {

        VStack{

            Text("\(TriviaManager.index) out of \(triviaManager.numberOfQuestions[0])")

            
            Text(triviaManager.questionArray[TriviaManager.index])
            
            Spacer()
            
            VStack{

                TriviaButton(text: triviaManager.answerArray[0]) 
                TriviaButton(text: triviaManager.answerArray[1])
                TriviaButton(text: triviaManager.answerArray[2])
                TriviaButton(text: triviaManager.answerArray[3])
            }
            Spacer()
        }
        .navigationTitle("TriviaQuiz")
    }
}

struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()

    }
}



