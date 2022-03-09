//
//  Answer.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-09.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
