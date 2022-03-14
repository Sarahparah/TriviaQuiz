//
//  SwiftUIView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-02-28.
//

import SwiftUI



struct ScoreView: View {
    
    var randomWords = ["Good job", "Almost there", "Score!"]
    @State var showAlert = false
    
    @EnvironmentObject var triviaManager : TriviaManager
    @Environment(\.managedObjectContext) private var viewContext
    @State var username = ""

    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.white, .yellow], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                Text("\(randomWords[1])")
                    .font(.system(size: 50))
                ZStack {
                    Capsule()
                        .fill(LinearGradient(colors: [.green, .teal], startPoint: .center, endPoint: .bottom))
                        .shadow(color: .white, radius: 40)
                        .padding(10)
                        //.rotationEffect(.init(degrees: 30))
                    ZStack {
                    Capsule()
                        .fill(.white)
                        .padding(30)
                        .shadow(color: .white, radius: 5)
                    Text("Your score")
                        .font(.system(size: 40))
                        .padding(.bottom, 250)
                    }
                    Circle()
                        .fill(.black)
                        .padding(90)
                        .shadow(color: .white, radius: 5)
    
                    Text("\(triviaManager.score)")
                        .font(.system(size: 180))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .blur(radius: 15.0)
                    
                    Text("\(triviaManager.score)")
                        .font(.system(size: 180))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Text("out of \(triviaManager.numberOfQuestions)")
                    .font(.system(size: 50))
                Spacer()
                
                VStack {
                    HStack {
                    Text("Save your score")
                        Spacer()
                    }

                HStack {
                    TextField("username", text: $username)
                    Button(action: {showAlert = true
                        addItem()
                    }) {
                        Text("Save")
                    }
                }
                }.padding(.leading, 10)
                    .padding(.trailing, 10)
//                NavigationLink(destination: TriviaView(), isActive: $triviaManager.isTriviaViewActive) {
//                    EmptyView()
//                }
//                NavigationLink(destination: SettingsView(), isActive: $isSettingsViewActive) {
//                    EmptyView()
//                }
                Button(action: {
                    triviaManager.isScoreViewActive = false
                    triviaManager.isTriviaViewActive = false
                    triviaManager.resetGame()
                }, label: {Text("Play again")})
                    .foregroundColor(.white)
                    .frame(width: 220, height: 50)
                    .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(30)
                
                Button(action: {
                    triviaManager.isScoreViewActive = false
                    triviaManager.isTriviaViewActive = false
                    triviaManager.index = 0
                    triviaManager.nextQuestion()
                    
                },
                       label: {
                    Text("See your answers")
                }).foregroundColor(.white)
                    .frame(width: 220, height: 50)
                    .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(30)
                
                
                NavigationLink(destination: HighScoreView()) {
                    Text("See Saved Scores")
                }
               // Spacer()
            }
        }.navigationBarBackButtonHidden(true)
        
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = username
            newItem.score = Int32(triviaManager.score)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}








struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(TriviaManager())
    }
}
