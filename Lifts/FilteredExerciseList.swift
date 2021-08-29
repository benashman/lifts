//
//  ExerciseList.swift
//  ExerciseList
//
//  Created by Benjamin Ashman on 8/30/21.
//

import SwiftUI
import CoreData

struct FilteredExerciseList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: FetchRequest<Exercise>
    
    @Binding var showingAddEntrySheet: Bool
    
    init(filter: String, showingAddEntrySheet: Binding<Bool>) {
        fetchRequest = FetchRequest<Exercise>(
            entity: Exercise.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "name CONTAINS[cd] %@", filter))
        
        _showingAddEntrySheet = showingAddEntrySheet
    }
    
    var exercises: FetchedResults<Exercise> { fetchRequest.wrappedValue }
    
    var body: some View {
        Text("Showing search results")
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
    }
}

//struct ExerciseList_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseList()
//    }
//}
