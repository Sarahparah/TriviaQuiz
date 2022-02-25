//
//  TriviaButton.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import Foundation
import UIKit
import SwiftUI

struct TriviaButton: View {
    
    var text: String
    var background: Color?

    var triviaManager = TriviaManager()

    var body: some View {
        
        Button(action: {
            print(text)
            triviaManager.index += 1
           // self.opacity(configuration.isPressed ? 0.7 : 1)
        }) {
            Text("\(text)")
                .foregroundColor(.green)
                .frame(width: 280, height: 50)
                .background(.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
        }.buttonStyle(MyButtonStyle())
    }
    
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.quaternary, in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
