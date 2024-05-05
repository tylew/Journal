////
////  Testing.swift
////  Journal
////
////  Created by Tyler Lewis on 5/4/24.
////
//
//import SwiftUI
//import CoreData
//
//struct MainView: View {
//    
////    @Environment(\.managedObjectContext) private var viewContext
////    @FetchRequest(
////        entity: CDNote.entity(),
////        sortDescriptors: [NSSortDescriptor(keyPath: \CDNote.creationDate_, ascending: true)]
////    ) var cdNotes: FetchedResults<CDNote>
////    
////    let notes = cdNotes.map(Note.init)
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(notes, id: \.self) { note in
//                    Text(note.text)
//                }
//                .onDelete(perform: deleteNotes)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: addNote) {
//                        Label("Add Note", systemImage: "plus")
//                    }
//                }
//            }
//            .navigationTitle("Notes")
//        }
//    }
//
//    private func addNote() {
//        let newNote = CDNote(context: viewContext)
//        newNote.title_ = "New Note"
//        newNote.creationDate_ = Date()
//        saveContext()
//    }
//
//    private func deleteNotes(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { notes[$0] }.forEach(viewContext.delete)
//            saveContext()
//        }
//    }
//
//    private func saveContext() {
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            print("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        let controller = PersistentController.preview
//        let context = controller.noteContainer.viewContext
//        MainView()
//            .environment(\.managedObjectContext, context)
//    }
//}
