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
                
                ScoreCircle()
                    .offset(y: -30)
                PlayAgainButton()
                    .offset(y: -20)
                SeeAnswersButton()
                    .offset(y: -10)
                SaveScoreBox(username: $username)
                Spacer()
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Sounds.playSounds(soundfile: "gameOver.wav")
        }
    }
    
    /**
     Returnerar olika fraser för att visas längst upp på sidan beroende på användarens score
     */
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
}

struct ScoreCircle: View {
    @EnvironmentObject var triviaManager : TriviaManager
    
    var body: some View {
        ZStack {
//MARK: - Outer circle
            
            Circle()
                .fill(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.blue, .red],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .shadow(color: .white, radius: 40)
                .padding(10)
            ZStack {
//MARK: - Middle circle
                
                Circle()
                    .fill(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.blue, .purple],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .padding(30)
                    .shadow(color: .white, radius: 5)
                Text("Your score")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(.bottom, 200)
                Text("out of \(triviaManager.numberOfQuestions)")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(.top, 200)
            }
//MARK: - Inner circle
            Circle()
                .fill(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [ .teal, .blue, .blue, .red,],
                                     startPoint: .topTrailing,
                                     endPoint: .bottomLeading))
                .padding(90)
                .shadow(color: .white, radius: 5)
            Text("\(triviaManager.score)")
                .font(.system(size: 160))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .blur(radius: 15.0)
            Text("\(triviaManager.score)")
                .font(.system(size: 120))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 10)
        }
    }
}

struct PlayAgainButton: View {
    @EnvironmentObject var triviaManager : TriviaManager

    var body: some View {
        Button(action: {
            triviaManager.isScoreViewActive = false
            triviaManager.isTriviaViewActive = false
            triviaManager.resetGame()
        }, label: {Text("PLAY AGAIN")})
            .foregroundColor(.white)
            .frame(width: 260, height: 70)
            .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(50)
            .shadow(color: .white, radius: 5)
    }
}
struct SeeAnswersButton: View {
    @EnvironmentObject var triviaManager : TriviaManager
    
    var body: some View {
        Button(action: {
            triviaManager.index = 0
            triviaManager.isAnswerViewActive = true
        },
               label: {
            Text("See your answers")
        }).foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(30)
            .shadow(color: .white, radius: 5)
    }
}

struct SaveScoreBox: View {
    @EnvironmentObject var triviaManager : TriviaManager
    @Binding var username: String
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            HStack {
                Text("Save your score")
                    .foregroundColor(.white)
                Spacer()
            }
            HStack {
                TextField("username", text: $username)
                    .foregroundColor(.white)
                Button(action: {
                    if username != "" {
                        addItem()
                        triviaManager.isHighScoreViewActive = true
                    }
                }) { Text("Save")
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                        .padding(7)
                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                }
            }
            HStack {
                Spacer()
                NavigationLink(destination: HighScoreView(), isActive: $triviaManager.isHighScoreViewActive) {
                    Text("See Saved Scores")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 16, alignment: .center)
                        .padding(7)
                        .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .white] : [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                }.isDetailLink(false)
            }
            NavigationLink(destination: AnswerView(), isActive: $triviaManager.isAnswerViewActive) {
                EmptyView()
            }.isDetailLink(false)
        }
        .frame(height: 80, alignment: .center)
        .padding(15)
        .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(5)
    }
    
/**
 Lägger till score i CoreData
 */
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
