//
//  SetEditor.swift
//  SetEditor
//
//  Created by Benjamin Ashman on 9/3/21.
//

import SwiftUI

struct SetEditor: View {
    @ObservedObject var selectedSet: EntrySet
    
    var body: some View {
        HStack {
            VStack {
                Text("Weight")
                Button(action: {
                    selectedSet.weight += 1
                }) {
                    Text("\(selectedSet.weight.cleanValue)")
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            VStack {
                Text("Reps")
                Button(action: {
                    selectedSet.reps += 1
                }) {
                    Text("\(selectedSet.reps)")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

//struct SetEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        SetEditor()
//    }
//}
