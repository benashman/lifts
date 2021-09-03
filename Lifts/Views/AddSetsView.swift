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
    
    @State var sets: [EntrySet] = []
    @State var notes = ""
    
    @State var selectedSetIndex: Int?
    
    @FetchRequest var previousEntries: FetchedResults<Entry>
    
    init(exercise: Exercise, showingAddEntrySheet: Binding<Bool>) {
        self._showingAddEntrySheet = showingAddEntrySheet
        self.exercise = exercise
        self._previousEntries = FetchRequest(
            entity: Entry.entity(),
            sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)],
            predicate: NSPredicate(format: "exercise.name == %@", "\(exercise.name ?? "")")
        )
    }
    
    var body: some View {
        
        List {
            Section(header: Text("Sets")) {
                ForEach(sets.indices, id: \.self) { index in
                    SetEditorRow(set: sets[index], index: index, selectedSetIndex: $selectedSetIndex)
                }
            }
            
            Section(header: Text("Notes")) {
                TextField("Notes", text: $notes) // TODO: use a TextEditor here eventually.
            }
            
            Section(header: Text("Editor")) {
                Group {
                    if selectedSetIndex != nil {
                        SetEditor(selectedSet: sets[selectedSetIndex!])
                    } else {
                        Text("Nada")
                    }
                }
            }
        }
        .onAppear() {
            // Seed first set for easier entry
            let firstSet = EntrySet(context: viewContext)
            
            // Fetch last logged set for this exercise and seed it
            if let mostRecentEntry = previousEntries.last {
                if let mostRecentSet = (mostRecentEntry.sets?.allObjects as? [EntrySet])?.last {
                    firstSet.weight = mostRecentSet.weight
                    firstSet.reps = mostRecentSet.reps
                }
            } else {
                firstSet.weight = 0
                firstSet.reps = 0
            }
            
            sets.append(firstSet)
        }
        .navigationTitle("\(exercise.name ?? "Unknown Exercise")")

        
//        Text("\(exercise.name!)")
//            .navigationTitle("\(exercise.name!)")
//        Button("Log dummy set") {
//            let newEntry = Entry(context: viewContext)
//            newEntry.timestamp = Date()
//            newEntry.exercise = exercise
//
//            for _ in 0..<3 {
//                let newSet = EntrySet(context: viewContext)
//                newSet.weight = Double.random(in: 2.5..<500)
//                newSet.reps = Int64(Int.random(in: 1..<12))
//                newSet.entry = newEntry
//            }
//
//            newEntry.notes = "Dummy set rom AddSetsView"
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//
//            showingAddEntrySheet.toggle()
//        }
    }
}

//struct AddSetsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSetsView()
//    }
//}
