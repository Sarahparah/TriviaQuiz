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



struct HighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreView()
    }
}
