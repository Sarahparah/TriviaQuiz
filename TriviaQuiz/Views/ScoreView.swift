//
//  SwiftUIView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-28.
//

import SwiftUI



struct ScoreView: View {
    
    @EnvironmentObject var triviaManager : TriviaManager
    
    
    var body: some View {
        
        
        Text("\(triviaManager.score) out of \(triviaManager.numberOfQuestions)")
    }
}








struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
