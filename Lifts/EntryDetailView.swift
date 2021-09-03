//
//  EntryDetailView.swift
//  EntryDetailView
//
//  Created by Benjamin Ashman on 9/3/21.
//

import SwiftUI

struct EntryDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    let entry: Entry

    @FetchRequest var relatedEntries: FetchedResults<Entry>
    
    init(entry: Entry) {
        self.entry = entry
        self._relatedEntries = FetchRequest(
            entity: Entry.entity(),
            sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)],
            predicate: NSPredicate(format: "exercise.name == %@", "\(entry.exercise?.name ?? "")")
        )
    }
    
    var body: some View {
        List {
            Section(header: Text("Sets")) {
                ForEach(Array(entry.sets as? Set<EntrySet> ?? []), id: \.self) { set in
                    HStack {
                        Text("\(set.weight.cleanValue)lb")
                        Text("✕")
                        Text("\(set.reps)")
                    }
                }
            }
            
            Section(header: Text("Notes")) {
                Text(entry.notesContent)
            }
            
            Section(header: Text("Previous logs")) {
                ForEach(relatedEntries) { entry in
                    EntryRow(entry: entry)
                }
            }
        }
        .navigationTitle(entry.exerciseName)
    }
}

//struct EntryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryDetailView()
//    }
//}
