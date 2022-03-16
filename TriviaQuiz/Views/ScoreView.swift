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
            LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.yellow, .purple, .orange], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            VStack {
                //MARK: - ReturnMessage Text
                Text("\(returnMessage())")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .offset(y: -30)
                    .multilineTextAlignment(.center)
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .white, radius: 40)
                        .padding(10)
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(30)
                            .shadow(color: .white, radius: 5)
                        Text("Your score")
                            .font(.system(size: 30))
                            .padding(.bottom, 220)
                        Text("out of \(triviaManager.numberOfQuestions)")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .padding(.top, 220)
                    }
                    Circle()
                        .fill(LinearGradient(colors: [ .teal, .blue, .blue, .red,], startPoint: .topTrailing, endPoint: .bottomLeading))
                        .padding(90)
                        .shadow(color: .white, radius: 5)
                    Text("\(triviaManager.score)")
                        .font(.system(size: 130))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .blur(radius: 15.0)
                    Text("\(triviaManager.score)")
                        .font(.system(size: 120))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .offset(y: -30)
                //MARK: Play Again knappen
                Button(action: {
                    triviaManager.isScoreViewActive = false
                    triviaManager.isTriviaViewActive = false
                    triviaManager.resetGame()
                }, label: {Text("Play again")})
                    .foregroundColor(.white)
                    .frame(width: 260, height: 70)
                    .background(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(50)
                    .offset(y: -20)
                //MARK: See Your Answers knappen
                Button(action: {
                    triviaManager.index = 0
                    triviaManager.isAnswerViewActive = true
                },
                       label: {
                    Text("See your answers")
                }).foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(30)
                    .offset(y: -10)
                
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
                        }) { Text("Save") }
                    }
                }
                
                Group {
                    HStack {
                        Spacer()
                        NavigationLink(destination: HighScoreView(), isActive: $triviaManager.isHighScoreViewActive) {
                            Text("See Saved Scores")
                        }.isDetailLink(false)
                    }
                    NavigationLink(destination: AnswerView(), isActive: $triviaManager.isAnswerViewActive) {
                        EmptyView()
                    }.isDetailLink(false)
                }
                Spacer()
            }.padding(.leading)
                .padding(.trailing)
        }.navigationBarBackButtonHidden(true)
    }
    
    //MARK: Bra switchsats 8^)
    
    private func returnMessage() -> String {
        
        switch triviaManager.score {
            
        case 0...Int(Double(triviaManager.numberOfQuestions)*0.3):
            return "You've got some reading to do!"
            
        case Int(Double(triviaManager.numberOfQuestions)*0.3)...Int(Double(triviaManager.numberOfQuestions)*0.5):
            return "Could've been better!"
            
        case Int(Double(triviaManager.numberOfQuestions)*0.5)...Int(Double(triviaManager.numberOfQuestions)*0.7):
            return "Wow, not bad!"
            
        case Int(Double(triviaManager.numberOfQuestions)*0.7)...Int(Double(triviaManager.numberOfQuestions)*0.9):
            return "Great job!"
            
        case triviaManager.numberOfQuestions:
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
            newItem.maxScore = Int32(triviaManager.numberOfQuestions)
            
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
