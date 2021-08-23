//
//  LiftsApp.swift
//  Lifts
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI

@main
struct LiftsApp: App {
    @AppStorage("hasPreviouslyLaunched") var hasPreviouslyLaunched: Bool = false
    
    let persistenceController = PersistenceController.shared

    init() {
        if !hasPreviouslyLaunched {
            // Seed data on first launch
            DataHelper.seedExercises()
            
            UserDefaults.standard.set(true, forKey: "hasPreviouslyLaunched")
        } else {
            print("App has previously launched")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ExercisesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
