//
//  HomeView.swift
//  Lifts
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: true)],
        animation: .default)
    private var entries: FetchedResults<Entry>
    
    @State private var searchText = ""
    
    @State var showingAddEntrySheet = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedEntries(entries).indices, id: \.self) { section in
                    Section(header: DateSectionHeader(date:
                        groupedEntries(entries)[section][0].timestamp!)) {
                        ForEach(groupedEntries(entries)[section], id: \.self) { entry in
                            EntryRow(entry: entry)
                        }
                        .onDelete { offsets in
                            deleteItems(offsets: offsets, section: section)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
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
    
    private func groupedEntries(_ result: FetchedResults<Entry>) -> [[Entry]] {
        return Dictionary(grouping: result) { (element: Entry) in
            dateFormatter.string(from: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
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

    private func deleteItems(offsets: IndexSet, section: Int) {
        withAnimation {
            offsets.map { groupedEntries(entries)[section][$0] }.forEach(viewContext.delete)

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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
