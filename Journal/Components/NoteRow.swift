//
//  NoteRow.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import SwiftUI

//struct NoteRow: View {
//    let note: Note  // Assuming Note is either a struct or a CoreData entity
//
//    var body: some View {
//        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
//            VStack(alignment: .leading){
//                HStack {
//                    Text(note.time, style: .date)
//                    Text(note.time, style: .time)  // Format time appropriately
//                    Spacer()
//                    Image(systemName: "ellipsis")
//                    
//                }.font(.system(size: 14))
//                Divider()
//                Text(note.content).fontWeight(.semibold)  // Display content
//            }.padding().background(Color.white)  // Set the background color of the VStack
//                .clipShape(RoundedRectangle(cornerRadius: 20))  // Clip the VStack with rounded corners
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)  // Same rounded rectangle as the clip
//                        .stroke(Color.appPurple, lineWidth: 2)  // Define the border color and width
//            )
//            Text(note.tags)
//                .font(.system(size: 15))
//                .foregroundColor(.white)
//                .padding(.horizontal, 7)
//                .padding(.vertical, 3)
//                .background(Color.appPurple.opacity(0.7))  // Tag background
//            
//                .clipShape(Capsule())  // Rounded capsule shape for tags
//                .shadow(radius: 3).offset(x: -40, y: -13)
////                .padding()
//        }
////            .padding()  // Add padding around the VStack to avoid clipping the shadow
////            .shadow(radius: 10)
//    }
//}

import SwiftUI
import CoreData

struct NoteRow: View {
    var note: Note

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title)
                    .font(.headline)
                Spacer()
                Text("contains \(note.contentBlockCount) blocks")
            }
            Text("Created on \(note.creationDate, formatter: Self.dateFormatter)")
                .font(.subheadline)
            if let lastModifiedDate = note.lastModifiedDate {
                Text("Last Modified on \(lastModifiedDate, formatter: Self.dateFormatter)")
                    .font(.subheadline)
            }
        }
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        // Use the preview controller to get the context
        let context = PersistentController.preview.noteContainer.viewContext

        // Fetch notes or create them on the fly as needed
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDNote.creationDate_, ascending: true)]
        
        let cdNotes = (try? context.fetch(fetchRequest)) ?? []

        let notes = cdNotes.map(Note.init)

        return NavigationView {
            
            VStack {
                Text("\(notes.count) total notes")
                List(notes, id: \.id) { note in
                        NavigationLink(destination: Text(note.title)) {
                          NoteRow(note: note)
                        }
                }.listStyle(PlainListStyle()) // Example using GroupedListStyle
                    .environment(\.horizontalSizeClass, .regular)
                    .background(Color.gray.opacity(0.2))
                    .navigationTitle("*Preview View")
            }
        }

    }
}

