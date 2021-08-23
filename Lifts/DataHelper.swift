//
//  DataHelper.swift
//  DataHelper
//
//  Created by Benjamin Ashman on 8/23/21.
//

import Foundation
import CoreData

struct DataHelper {
    
    static var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    static func seedExercises() {
        print("🌱 Seeding exercises…")
        
        let exercises = [
            "Squat",
            "Bench Press",
            "Deadlift",
            "Overhead Press"
        ]
        
        for exercise in exercises {
            let newExercise = Exercise(context: viewContext)
            newExercise.name = exercise
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
