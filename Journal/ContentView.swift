//
//  ContentView.swift
//  Journal
//
//  Created by Tyler Lewis on 5/2/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var navigateToTextBlock = false
    @State private var newNote: CDNote?

    var body: some View {
        NavigationView {
            VStack {
                Button("Create New Note") {
                    createNewNote()
                    navigateToTextBlock = true
                }
                .navigationTitle("Note Creator")
                .disabled(navigateToTextBlock)  // Disable while navigating

                NavigationLink(destination: TextBlockView(note: $newNote), isActive: $navigateToTextBlock) {
                    EmptyView()
                }
            }
        }
    }
    
    private func createNewNote() {
        let note = CDNote(context: viewContext)
        note.title = "New Note"
        newNote = note
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct TextBlockView: View {
    @Binding var note: CDNote?
    @Environment(\.managedObjectContext) private var viewContext
    @State private var textContent: String = ""

    var body: some View {
        Form {
            TextField("Enter text for the block", text: $textContent)
            Button("Add Text Block") {
                addTextBlockToNote()
            }
            .disabled(textContent.isEmpty)
        }
        .navigationTitle("Add Text Block")
    }
    
    private func addTextBlockToNote() {
        guard let note = note else { return }
        let textBlock = CDTextBlock(context: viewContext, note: note)
        note.addContentBlock(textBlock)
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

// Assume CDNote and CDTextBlock are defined in your CoreData model with appropriate attributes and relationships.

