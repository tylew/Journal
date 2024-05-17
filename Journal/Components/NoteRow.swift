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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.title3)
                
                Text("Created: \(note.creationDate, formatter: Self.dateFormatter)")
                    .foregroundColor(.gray).font(.system(size: 13)).padding(.top, 1)
                
                
            }
            Spacer()
            Image(systemName: "\(note.contentBlocksCount).circle")
//            Text("Created on \(note.creationDate, formatter: Self.dateFormatter)")
                .font(.system(size: 25)).foregroundColor(Color.appPurple.opacity(0.9)).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            Image(systemName: "chevron.right").foregroundColor(Color.appPurple)
            
        }
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}
