//
//  SetEditorRow.swift
//  SetEditorRow
//
//  Created by Benjamin Ashman on 9/3/21.
//

import SwiftUI

struct SetEditorRow: View {
    @ObservedObject var set: EntrySet
    
    var index: Int
    
    // The selected set in the parent's radio list
    @Binding var selectedSetIndex: Int?
    
    // Human-readable set numbers
    var setNumber: Int {
        index + 1
    }
    
    var body: some View {
        Button(action: {
            // Mark this set as selected for the editor
            selectedSetIndex = index
        }) {
            HStack {
                Text("\(setNumber):")
                Text("\(set.weight.cleanValue)")
                Text("✕")
                Text("\(set.reps)")
            }
            .foregroundColor(selectedSetIndex == index ? .blue : .primary)
        }
    }
}

//struct SetEditorRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SetEditorRow()
//    }
//}
