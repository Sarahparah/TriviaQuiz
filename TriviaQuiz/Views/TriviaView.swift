//
//  TriviaView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import SwiftUI

struct TriviaView : View {
    
    var body: some View {
        VStack{
            Text("Trivia Game")
            
            Text("Question")
            
            Spacer()
            
            VStack{
                TriviaButton(text: "Answer 1")
                TriviaButton(text: "Answer 2")
                TriviaButton(text: "Answer 3")
                TriviaButton(text: "Answer 4")
            }
            Spacer()
            
            
            
        }
    }
    
}



struct TriviaViewPreviews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            
    }
}
