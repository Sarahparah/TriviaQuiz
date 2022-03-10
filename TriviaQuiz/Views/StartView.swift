//
//  ContentView.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    @State var animateGradient = false

    let blueColorArray = [Color.blue, Color.white]

    let grayColorArray = [Color(UIColor(named: "GrayColorOne")!),
                          Color(UIColor(named: "GrayColorTwo")!),
                          Color(UIColor(named: "GrayColorThree")!),
                          Color(UIColor(named: "GrayColorFour")!),
                          Color(UIColor(named: "GrayColorFive")!)]
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: triviaManager.isColorMode ? grayColorArray : [.red, .yellow, .purple],
                               startPoint: animateGradient ? .topLeading : .bottomTrailing,
                               endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                    .ignoresSafeArea()

                VStack {

                    ZStack {

                        Circle()
                            .fill(LinearGradient(colors: triviaManager.isColorMode ? grayColorArray : [.red, .white],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .padding()

                        NavigationLink(destination: SettingsView()) {

                            ZStack{
                                Circle()
                                    .fill(triviaManager.isColorMode ?

                                          LinearGradient(colors: grayColorArray,

                                                         startPoint: .topLeading,

                                                         endPoint: .bottomTrailing) :
                                            LinearGradient(colors: [.red, .purple],
                                                           startPoint: .topLeading,
                                                           endPoint: .bottomTrailing))
                                    .padding(50)
                                    .shadow(color: .white, radius: 5)

//MARK: Middle circle image

                                Image(triviaManager.isColorMode ? "grayGradient" : "PurpleGradient")
                                //PurpleGradient
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 300)
                                    .cornerRadius(150)

//MARK: Centre circle

//                                Circle()
//                                    .fill(triviaManager.isColorMode ? .black : .purple)
//                                    .padding(110)
//                                    .shadow(color: .white, radius: 5)

                                Image(triviaManager.isColorMode ? "SpaceStarsTwo" : "orangeGradient")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 155, height: 155)
                                    .cornerRadius(150)




                                Text("Enter game")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .bold()
                            }
                        }
                    }
                    .offset(y: -60)
                    .navigationTitle("TriviaQuiz")

//MARK: Triviabutton

                    Button {
                        triviaManager.isColorMode.toggle()
                    } label: {
                       Text("Toggle ColorMode")
//                        TextShimmer(text: "Toggle ColorMode")
                    }.foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: triviaManager.isColorMode ? grayColorArray : [.purple, .pink],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))
                        .cornerRadius(30)

                }
            }
        }.environmentObject(triviaManager)
    }

}


//struct TextShimmer: View {
//
//    var text: String
//    @State var animation = false
//
//    var body: some View {
//
//        ZStack{
//
//            Text(text)
//                .font(.system(size:75, weight: .bold))
//                .foregroundColor(Color.white.opacity(0.25))
//
//            //Multicolor Text...
//
//            HStack(spacing: 0) {
//
//                ForEach(0..<text.count,id: \.self){index in
//
//                    Text(String(text[text.index(text.startIndex, offsetBy:
//                                               index)]))
//                        .font(.system(size: 75, weight: .bold))
//                        .foregroundColor(randomColor())
//                }
//            }
//            // Masking for Shimmer Effect...
//            .mask(
//                Rectangle()
//                    .fill(
//                        LinearGradient(gradient: .init(colors:
//                                                        [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]),
//                                       startPoint: .top,
//                                       endPoint: .bottom)
//                    )
//                    .rotationEffect(.init(degrees: 70))
//                    .padding(20)
//                    .offset(x: -250)
//                    .offset(x: animation ? 500 : 0)
//            )
//            .onAppear(perform: {
//                withAnimation(Animation.linear(duration:
//                                                2).repeatForever(autoreverses: false)){
//                    animation.toggle()
//                }
//            })
//        }
//    }
//
//
//    func randomColor()->Color {
//        let color = UIColor(red: 1, green: .random(in: 0...1),
//                            blue: .random(in: 0...1), alpha: 1)
//        return Color(color)
//    }
//}







