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
    
    
    var body: some View {
        
        Button(action: {
            print(text)
        }) {
            Text("\(text)")
                .foregroundColor(.green)
                .frame(width: 280, height: 50)
                .background(.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
                
        }
    }
    
}
