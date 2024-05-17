//////
//////  HomeView.swift
//////  Journal
//////
//////  Created by Tyler Lewis on 5/2/24.
//

import SwiftUI
import CoreData

// Home page for journaling app, provide navigation to note containers
struct NoteNavigationView: View {
//   viewContext derived from @persistentController within @root
    @Environment(\.managedObjectContext) var viewContext
    @State private var notes: [CDNote] = []
    @State private var newNote: CDNote?
//    Listening to these Bools to handle navigation to new views
    @State private var navigateToNewNote = false
    @State private var showingSettings = false
    
    
//    Load all notes, future improvment would want to potentially pagnate
    private func loadNotes() {
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDNote.creationDate_, ascending: true)]
        
        do {
            notes = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }
    
//    Handle logic for creating new CDNote + navigating to NoteView
    private func addNote() {
        let newNote = CDNote(context: viewContext)
        do {
            try viewContext.save()
            notes.append(newNote)
            self.newNote = newNote
            navigateToNewNote = true
            print("Saved")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error: \(nsError), \(nsError.userInfo)")
        }
    }

//    Delete CDNotes by indexSet
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately
                print("Failed to save context: \(error)")
                // Optionally, present an alert to the user
            }
        }
    }
    
//    Display body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("\(notes.count) notes")
                    .padding(.vertical, 5) // Adds padding vertically
                    .padding(.horizontal, 20) // Adds padding horizontally for wider appearance
                    .background(Color.appPurple.opacity(0.2)) // Sets the background color
                    .foregroundColor(.appPurple) // Sets the text color
                    .clipShape(Capsule()) // Creates the pill shape
                    .padding(.bottom, 5)
                
                Divider().frame(minHeight: 1).overlay(Color.appPurple.opacity(0.5))
                
                List {
                    ForEach(notes, id: \.self) { note in
                        ZStack {
                            NavigationLink(destination: CDNoteDetailView(note: note).environment(\.managedObjectContext, viewContext)) {
                                
                            }.opacity(0)
                            NoteRow(note: note)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                
                Divider().frame(minHeight: 1).overlay(Color.appPurple.opacity(0.5)).padding(0)
                
                Button("Add Note") {
                    addNote()
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.top, 5)
                
                .navigationTitle("Neptune Notebook")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                                leading: Button(action: {
                                    showingSettings.toggle()
                                }) {
                                    Image(systemName: "gear")
                                }
//                                trailing: EditButton()  ** Giving odd behavior
                            )
                .navigationDestination(isPresented: $navigateToNewNote) {
                    // Safely unwrap newNote, or provide a fallback view
                    if let newNote = newNote {
                        CDNoteDetailView(note: newNote)
                    } else {
                        Text("No new note to display") // Fallback view
                    }
                }
            }.onAppear {
                loadNotes()
            }.sheet(isPresented: $showingSettings, content: {
                SettingsView()
            })
            
        }.navigationViewStyle(DoubleColumnNavigationViewStyle()).accentColor(Color.appPurple)
    }
}

#if DEBUG
struct NoteRow_Previews: PreviewProvider {
    

    static var previews: some View {
        // Explicitly set the environment here
        NoteNavigationView().environment(\.managedObjectContext, PersistentController.preview.noteContainer.viewContext)
    }
}
#endif
