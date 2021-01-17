//
//  EsercizioCoreDataApp.swift
//  EsercizioCoreData
//
//  Created by Michele on 17/01/21.
//

import SwiftUI

@main
struct EsercizioCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
