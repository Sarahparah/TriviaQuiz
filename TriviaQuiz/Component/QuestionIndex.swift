//
//  QuestionIndex.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-25.
//

import SwiftUI

struct QuestionIndex: View {
    
    @EnvironmentObject var triviaManager: TriviaManager

    var body: some View {
        Text("\(triviaManager.index) out of \(triviaManager.numberOfQuestions)")
        
    }
}

struct QuestionIndex_Previews: PreviewProvider {
    static var previews: some View {
        QuestionIndex()
    }
}
