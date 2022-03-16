//
//  Answer.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-09.
//

import Foundation

class Answer: Identifiable, Decodable {
    
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
    var isSelected: Bool = false
    
    init(text: AttributedString, isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect
    }
    
}
