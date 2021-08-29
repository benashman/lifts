//
//  ExercisesView.swift
//  ExercisesView
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI
import CoreData

struct ExercisesView: View {
    @Binding var showingAddEntrySheet: Bool
    
    @State private var searchText = ""
    
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
