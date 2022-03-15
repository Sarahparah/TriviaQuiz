//
//  HighScoreView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-14.
//

import SwiftUI

struct HighScoreView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.score, order: .reverse)])
    var items : FetchedResults<Item>

    let blueColorArray = [Color.blue, Color.white]
    @EnvironmentObject var triviaManager : TriviaManager

    init() {

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

    }

    var body: some View {

        ZStack{

            //            LinearGradient(colors: triviaManager.isColorMode ? blueColorArray : [.red, .blue, .yellow],
            //                           startPoint: .topLeading,
            //                           endPoint: .bottomTrailing)
            //                .ignoresSafeArea()

            if triviaManager.isColorMode {

                AnimatedBackgroundTwo().edgesIgnoringSafeArea(.all)
                    .blur(radius:50)


            } else {

                AnimatedBackground().edgesIgnoringSafeArea(.all)
                    .blur(radius:50)
            }

            List {
                ForEach(items) { item in
                    HStack {
                        if let name = item.name {
                            Text(name)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        if let score = item.score {
                            if let maxScore = item.maxScore {
                                Text("\(score) / \(maxScore)")
                                    .foregroundColor(.white)
                            }

                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("HighScoreView")
            .foregroundColor(.white)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

struct AnimatedBackgroundTwo: View {

    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x:4, y: 0)

    @State var isAnimating = false {
        didSet {
            print("anim \(isAnimating)")
        }
    }


    //let timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    // @State var colors = [Color.blue, Color.red, Color.purple, Color.pink, Color.yellow,
     //                 Color.green, Color.orange]
    let colors = [Color.blue, Color.white] // : [Color.blue, Color.purple, Color.yellow]

    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start,
                       endPoint: end)

            .animation(
                Animation.easeInOut(duration: 3).repeatForever(),   //Frame Size startar på 0 när gränssnittet initieras pga navigationview
                value: start // och animationen kickar igång direkt, vilket resulterar i att det animeras när storleken på vyerna sätts
            )
            .onAppear {
                print("onappear")
                DispatchQueue.main.async {
                    self.start = UnitPoint(x: 4, y: 0)
                    self.end = UnitPoint(x: 0, y: 2)
                    //self.isAnimating = true
                }
            }
//            .onReceive(timer, perform: { _ in
//                print("tick")
//                //self.isAnimating = !self.isAnimating
//                //self.colors = colors.shuffled()
//                //self.start = UnitPoint(x: 4, y: 0)
//                self.end = UnitPoint(x: 0, y: 2)
//                //self.start = UnitPoint(x:4, y: 20)
//                self.start = UnitPoint(x: 4, y: 0)
//            })
    }
}



//
//struct HighScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        HighScoreView()
//    }
//}
