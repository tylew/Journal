//
//  CDModels.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import Foundation

struct Note {
    var id: UUID
    var title: String
    var creationDate: Date
    var lastModifiedDate: Date?
    var contentBlocks: [ContentBlock]  // Assuming ContentBlock is a struct representing CDContentBlock

    init(cdNote: CDNote) {
        self.id = cdNote.id
        self.title = cdNote.title
        self.creationDate = cdNote.creationDate
        self.lastModifiedDate = cdNote.lastModifiedDate
        
        // Convert NSOrderedSet to Array of ContentBlock structs
        self.contentBlocks = cdNote.contentBlocks.array.compactMap { ($0 as? CDContentBlock).map(ContentBlock.init) }
    }
    
    // Computed property to get the count of contentBlocks
    var contentBlockCount: Int {
        contentBlocks.count
    }
}
