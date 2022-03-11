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
    //@State var isColorMode = true
    let blueColorArray = [Color.blue, Color.white]
    @Environment(\.managedObjectContext) var viewContext
        
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .yellow, .purple], startPoint: animateGradient ? .topLeading : .bottomTrailing, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                    .ignoresSafeArea()
                //                    .onAppear {
                //                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                //                            animateGradient.toggle()
                //                        }
                //                    }

                VStack {

                    ZStack {

                        Circle()
                            .fill(LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .white],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .padding()

                       // NavigationLink(destination: SettingsView()) {
                        NavigationLink(destination: SettingsView(), isActive: $triviaManager.isSettingsViewActive) {
                            EmptyView()
                        }
                            ZStack{
                                Circle()
                                    .fill(triviaManager.isColorMode ? LinearGradient(colors: [.blue, .purple],
                                                                                     startPoint: .topLeading,
                                                                                     endPoint: .bottomTrailing) :
                                            LinearGradient(colors: [.red, .purple],
                                                           startPoint: .topLeading,
                                                           endPoint: .bottomTrailing))
                                    .padding(50)
                                    .shadow(color: .white, radius: 5)

                                Circle()
                                    .fill(triviaManager.isColorMode ? .blue : .yellow)
                                    .padding(110)
                                    .shadow(color: .white, radius: 5)
                                Text("Enter game")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .bold()
                            }
                            .onTapGesture {
                                triviaManager.isSettingsViewActive = true
                            }
                       // }
                    }
                    .offset(y: -60)
                    .navigationTitle("TriviaQuiz")
                    Button {
                        triviaManager.isColorMode.toggle()
                        triviaManager.colorMode = ColorMode(context: viewContext)
                        triviaManager.colorMode.color = triviaManager.isColorMode
                       // triviaManager.isColorMode = colorMode.color
//                        let newItem = ColorMode(context: viewContext)
//                        print(newItem.color)
                    } label: {
                        Text("Toggle ColorMode")
                    }.foregroundColor(.white)
                        //.frame(width: 160, height: 55)
                        .frame(width: 220, height: 50)
                        .background(LinearGradient(colors: triviaManager.isColorMode ? [.blue, .cyan] : [.purple, .pink],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))
                        .cornerRadius(30)

                }
            }
        }.environmentObject(triviaManager)
            .navigationViewStyle(.stack)
    }
//    func toggleColorMode() {
//      //  colorMode.color.toggle
//        viewContext.save()
//        do {
//            try viewContext.save()
//        } catch {
//            print("Error saving colorMode")
//        }
//    }
    
//    func fetchCoreDate() {
//        let fetchRequest: NSFetchRequest<ColorMode> = ColorMode.fetchRequest()
//        do {
//            viewContext.fetch(fetchRequest)
//        }
//    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//
//    }
//}





