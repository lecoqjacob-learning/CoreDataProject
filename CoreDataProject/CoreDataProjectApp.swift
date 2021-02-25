//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Jacob LeCoq on 2/23/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DynamicFilteringContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
