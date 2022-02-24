//
//  PickerStack.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-02-24.
//

import Foundation
import SwiftUI

struct PickerStack:  View {
    
    var array: [String]
    var title: String
    //var color: Color
   @State var index = 0
    
    
    var body: some View {
        
    VStack{
        
        HStack{
            
            Text("Selected \(title): \(array[index])")
            
        }
    
        Picker(selection: $index, label: Text(""))
        {
            ForEach(0..<array.count){
                Text("\(self.array[$0])")
            }
            
            
            }
        .pickerStyle(SegmentedPickerStyle())
        
        }
        
    }
}


