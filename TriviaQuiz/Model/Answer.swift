//
//  Answer.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-09.
//

import Foundation

class Answer: Decodable { //answerklassen som förhåller sig till decodable protokollet 
    
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
    var isSelected: Bool = false
    
    
    /*
     Här initialiseras klassen Answer 
     */
    init(text: AttributedString, isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect
    }
    
}
