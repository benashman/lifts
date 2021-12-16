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
    
    @Binding var showingAddEntrySheet: Bool
    
    @State private var searchText = ""
    
    @State var showingAddNewExerciseSheet = false
    
    var body: some View {
        NavigationView {
            Group {
                if searchText.isEmpty {
                    AllExercisesList(showingAddEntrySheet: $showingAddEntrySheet)
                } else {
                    FilteredExerciseList(filter: searchText, showingAddEntrySheet: $showingAddEntrySheet)
                }
            }
            .navigationTitle("Choose exercise")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingAddEntrySheet.toggle()
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddNewExerciseSheet.toggle()
                    }) {
                        Label("Add Exercise", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNewExerciseSheet) {
                AddNewExerciseView(showingAddNewExerciseView: $showingAddNewExerciseSheet)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

//struct ExercisesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExercisesView()
//    }
//}
