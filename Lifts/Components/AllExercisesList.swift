//
//  AllExercisesList.swift
//  AllExercisesList
//
//  Created by Benjamin Ashman on 8/30/21.
//

import SwiftUI

struct AllExercisesList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: true)],
        animation: .default)
    private var exercises: FetchedResults<Exercise>
    
    @Binding var showingAddEntrySheet: Bool
    
    var body: some View {
        List {
            ForEach(exercises) { exercise in
                NavigationLink(
                    destination: AddSetsView(exercise: exercise, showingAddEntrySheet: $showingAddEntrySheet),
                    label: {
                        Text("\(exercise.name!)")
                    }
                )
            }
        }
    }
}

//struct AllExercisesList_Previews: PreviewProvider {
//    static var previews: some View {
//        AllExercisesList()
//    }
//}
