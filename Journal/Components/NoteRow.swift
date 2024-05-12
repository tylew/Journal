//
//  NoteRow.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import SwiftUI
import CoreData

struct NoteRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var note: CDNote

//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text(note.title)
//                    .font(.headline)
//                Spacer()
//                Text("\(note.contentBlocksCount) blocks")
//                Image(systemName: "\(note.contentBlocksCount).circle")
//            }
////            Text("Created on \(note.creationDate, formatter: Self.dateFormatter)")
//                .font(.subheadline)
//            if let lastModifiedDate = note.lastModifiedDate {
//                Text(lastModifiedDate, formatter: Self.dateFormatter)
//                    .font(.subheadline)
//            }
//        }
//    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.headline)
                
                if let lastModifiedDate = note.lastModifiedDate {
                    Text(lastModifiedDate, formatter: Self.dateFormatter)
                        .font(.subheadline)
                }
                
            }
            Spacer()
            Image(systemName: "\(note.contentBlocksCount).circle")
//            Text("Created on \(note.creationDate, formatter: Self.dateFormatter)")
                .font(.system(size: 20)).foregroundColor(.red).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}
