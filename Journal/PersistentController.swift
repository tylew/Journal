//
//  PersistenceController.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import CoreData

struct PersistentController {
    // Singleton for global access
    static let shared = PersistentController()

    // NSPersistentContainer manages the Core Data stack
    let noteContainer: NSPersistentContainer

    // Initializer to load the .xcdatamodel
    init(inMemory: Bool = false) {
        noteContainer = NSPersistentContainer(name: "DataModel")
        
        // FOR PREVIEW SETUP, INITIALIZE IN MEM
        if inMemory {
            // Configure the persistent store to be in-memory
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            noteContainer.persistentStoreDescriptions = [description]
        }
        
        // Load the persistent stores
        noteContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Typical handling of Core Data errors involves throwing an error in production apps
                // For development, you might want to use fatalError to ensure the error is noticed
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // Optional: Configure the container or context here if needed
        configureContext()
    }

    private func configureContext() {
        // For example, you might want to set some default configurations on the context,
        // like merging policies or undo management.
        noteContainer.viewContext.automaticallyMergesChangesFromParent = true
        noteContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        noteContainer.viewContext.undoManager = nil // Not using undo manager to optimize performance
    }
#if DEBUG
    static var preview: PersistentController = {
        let controller = PersistentController(inMemory: true)
        let viewContext = controller.noteContainer.viewContext
        
        
        // Creating sample notes
        let note1 = CDNote(context: viewContext)
        note1.title = "First Note"
        
        let note2 = CDNote(context: viewContext)
        note2.title = "Second Note"
        
        let textBlock1 = CDTextBlock(context: viewContext, note: note1)
        textBlock1.text = "text block 1"
        let textBlock11 = CDTextBlock(context: viewContext, note: note1)
        textBlock11.text = "text block 11"
        
        let textBlock2 = CDTextBlock(context: viewContext, note: note2)
        textBlock2.text = "text block 2"
        
        do {
            try viewContext.save()
        } catch {
            // Handle errors as appropriate
            print("Unresolved error \(error.localizedDescription)")
        }
        return controller
    }()
    
#endif
}
