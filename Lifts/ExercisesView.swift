//
//  ExercisesView.swift
//  ExercisesView
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI
import CoreData

struct ExercisesView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: true)],
        animation: .default)
    private var exercises: FetchedResults<Exercise>
    
    @Binding var showingAddEntrySheet: Bool
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    NavigationLink(
                        destination: AddSetsView(showingAddEntrySheet: $showingAddEntrySheet, exercise: exercise),
                        label: {
                            Text("\(exercise.name!)")
                        }
                    )
                }
            }
            .navigationTitle("Choose exercise")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingAddEntrySheet.toggle()
                    }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

//struct ExercisesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExercisesView()
//    }
//}
