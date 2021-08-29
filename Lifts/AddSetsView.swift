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
        Button("Log dummy set") {
            let newEntry = Entry(context: viewContext)
            newEntry.timestamp = Date()
            newEntry.exercise = exercise
            
            for _ in 0..<3 {
                let newSet = Set(context: viewContext)
                newSet.weight = Double.random(in: 2.5..<500)
                newSet.reps = Int64(Int.random(in: 1..<12))
                newSet.entry = newEntry
            }
            
            newEntry.notes = "Dummy set rom AddSetsView"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            showingAddEntrySheet.toggle()
        }
    }
}

//struct AddSetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSetsView()
//    }
//}
