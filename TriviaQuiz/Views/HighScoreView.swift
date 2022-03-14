//
//  HighScoreView.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-14.
//

import SwiftUI

struct HighScoreView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)])
    var items : FetchedResults<Item>
    
    //    init(filter: String = "" ) {
    //        if filter == "" {
    //            _items = FetchRequest<Item>(
    //                sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //                animation: .default
    //                )
    //    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    if let name = item.name {
                        Text(name)
                    }
                    Spacer()
                    if let score = item.score {
                        Text("\(score)")
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            //            for index in offsets {
            //                let item = items[index]
            //                viewContext.delete(item)
            //            }
            
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
//
//struct HighScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        HighScoreView()
//    }
//}
