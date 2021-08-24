//
//  AddSetsView.swift
//  AddSetsView
//
//  Created by Benjamin Ashman on 8/24/21.
//

import SwiftUI
import CoreData

struct AddSetsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showingAddEntrySheet: Bool
    
    let exercise: Exercise
    
    var body: some View {
        Text("\(exercise.name!)")
            .navigationTitle("\(exercise.name!)")
    }
}

//struct AddSetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSetsView()
//    }
//}
