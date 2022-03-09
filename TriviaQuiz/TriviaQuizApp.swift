//
//  TriviaQuizApp.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

@main
struct TriviaQuizApp: App {
    
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase

    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
    }

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .onChange(of: scenePhase) { _ in
                persistenceController.save()
            }
        }
    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
}
