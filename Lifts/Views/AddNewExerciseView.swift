//
//  AddNewExerciseView.swift
//  AddNewExerciseView
//
//  Created by Benjamin Ashman on 9/3/21.
//

import SwiftUI

struct AddNewExerciseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showingAddNewExerciseView: Bool

    @State var newExerciseName = ""
    
    var body: some View {
        NavigationView {
            List {
                TextField("Exercise Name", text: $newExerciseName)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingAddNewExerciseView.toggle()
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addExercise()
                    }) {
                        Text("Done")
                    }
                }
            }
            .navigationTitle("Add New Exercise")
        }
    }
    
    private func addExercise() {
        let newExercise = Exercise(context: viewContext)
        newExercise.name = newExerciseName

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        showingAddNewExerciseView.toggle()
    }
}

//struct AddNewExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewExerciseView()
//    }
//}
