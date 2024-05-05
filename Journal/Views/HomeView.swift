//////
//////  HomeView.swift
//////  Journal
//////
//////  Created by Tyler Lewis on 5/2/24.
//
//import SwiftUI
//import CoreData
//
//struct MainView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: CDNote.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \CDNote.creationDate_, ascending: true)]
//    ) var cdNotes: FetchedResults<CDNote>
//
//    var body: some View {
//        NavigationView {
//            List(cdNotes, id: \.self) { cdNote in
//                NavigationLink(destination: NoteRow(cdNote: cdNote)) {
//                    Text(cdNote.title ?? "Untitled Note")
//                }
//            }
//            .navigationTitle("Notes")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: addNote) {
//                        Label("Add Note", systemImage: "plus")
//                    }
//                }
//            }
//        }
//    }
//
//    private func addNote() {
//        let newNote = CDNote(context: viewContext)
//        newNote.title = "Newer Note"
//        try? viewContext.save()
//    }
//}
