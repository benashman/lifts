//
//  LiftsApp.swift
//  Lifts
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI

@main
struct LiftsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
