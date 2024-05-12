//
//  JournalApp.swift
//  Journal
//
//  Created by Tyler Lewis on 5/2/24.
//

import SwiftUI

@main
struct JournalApp: App {
    let persistenceController = PersistentController.shared
    
    var body: some Scene {
        WindowGroup {
//            NoteNavigationView()
//                .environment(\.managedObjectContext, persistenceController.viewContext.)
            
            NoteNavigationView().environment(\.managedObjectContext, persistenceController.noteContainer.viewContext)
        }
    }
}
