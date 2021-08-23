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
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    Text("\(exercise.name!)")
                }
            }
            .navigationTitle("Exercises")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
