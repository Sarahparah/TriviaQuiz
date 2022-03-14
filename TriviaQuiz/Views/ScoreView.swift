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

            LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.yellow, .purple, .orange],
                           startPoint: .topTrailing,
                           endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()

//MARK: - ReturnMessage Text

                Text("\(returnMessage())")

                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .offset(y: -30)
                    .multilineTextAlignment(.center)

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
                        Button(action: {
                            if username != "" {
                                addItem()
                                triviaManager.isHighScoreViewActive = true
                            }
                        }) {
                            Text("Save")
                        }
                    }
                }.padding(.leading, 10)
                    .padding(.trailing, 10)



//MARK: Play Again knappen

                Button(action: {
                    triviaManager.isScoreViewActive = false
                    triviaManager.isTriviaViewActive = false
                    triviaManager.resetGame()
                }, label: {Text("Play again")})
                    .foregroundColor(.white)
                    .frame(width: 220, height: 50)
                    .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(30)

                Spacer()

//MARK: See Your Answers knappen
                
                Button(action: {
                   // triviaManager.isGameEnded = false
                    triviaManager.index = 0
                   // triviaManager.isScoreViewActive = false
                   // triviaManager.isTriviaViewActive = false
                   // triviaManager.isSettingsViewActive = false
                    triviaManager.isAnswerViewActive = true
                   // triviaManager.nextQuestion()
                },
                       label: {
                    Text("See your answers")
                }).foregroundColor(.white)
                    .frame(width: 220, height: 50)
                    .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(30)

                Group {
                NavigationLink(destination: HighScoreView(), isActive: $triviaManager.isHighScoreViewActive) {
                    Text("See Saved Scores")
                }.isDetailLink(false)
                
                NavigationLink(destination: AnswerView(), isActive: $triviaManager.isAnswerViewActive) {
                    EmptyView()
                }.isDetailLink(false)
                }
                
                // Spacer()
            }
        }.navigationBarBackButtonHidden(true)
        
    }

    //    private func returnMessage() -> String {
    //
    //        print("ReturnMessage score = \(triviaManager.score)")
    //
    //        if triviaManager.score > 9 {
    //            return "Good job!"
    //        } else if triviaManager.score > 7 {
    //            return "Wow, not bad!"
    //        } else if triviaManager.score > 5 {
    //            return "Could've been better"
    //        } else if triviaManager.score > 3 {
    //            return "You've got some reading to do..."
    //        } else {
    //            return ":("
    //        }
    //    }

//MARK: Bra switchsats 8^)

    private func returnMessage() -> String {

        switch triviaManager.score {

        case 0...3:
            return "You've got some reading to do!"

        case 3...5:
            return "Could've been better!"

        case 5...7:
            return "Wow, not bad!"

        case 7...9:
            return "Good job!"

        case 10:
            return "Trivia Master!"

        default:
            return "Have you done something wrong?"
        }
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
