//
//  TriviaQuizApp.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

@main
struct TriviaQuizApp: App {
    
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
