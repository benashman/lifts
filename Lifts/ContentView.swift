//
//  ContentView.swift
//  Lifts
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: true)],
        animation: .default)
    private var entries: FetchedResults<Entry>
    
    @State private var searchText = ""
    
    @State var showingAddEntrySheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    EntryRow(entry: entry)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddEntrySheet.toggle()
                    }) {
                        Text("Add Entry")
                    }
                }
            }
            .sheet(isPresented: $showingAddEntrySheet) {
                ExercisesView(showingAddEntrySheet: $showingAddEntrySheet)
                    .environment(\.managedObjectContext, viewContext)
            }
            .navigationTitle("Lifts")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }

    private func addItem() {
        withAnimation {
            let newEntry = Entry(context: viewContext)
            newEntry.timestamp = Date()

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }.forEach(viewContext.delete)

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
