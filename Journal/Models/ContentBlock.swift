//
//  ContentBlock.swift
//  Journal
//
//  Created by Tyler Lewis on 5/4/24.
//

import Foundation

struct ContentBlock {
    var id: UUID
    var creationDate: Date
    var lastModifiedDate: Date?
    var type: BlockType
    
    // Define an enum to handle different types of content blocks
    enum BlockType {
        case text(String)
        case image(URL)  // Example for future extension
        case video(URL)  // Example for future extension
        
        // Initialize from a CDContentBlock instance
        init(cdContentBlock: CDContentBlock) {
            if let textBlock = cdContentBlock as? CDTextBlock {
                self = .text(textBlock.text)
            } else {
                // Handle other types as necessary
                self = .text("") // Default or error handling
            }
        }
    }
    
    init(cdContentBlock: CDContentBlock) {
        self.id = cdContentBlock.id
        self.creationDate = cdContentBlock.creationDate
        self.lastModifiedDate = cdContentBlock.lastModifiedDate
        self.type = BlockType(cdContentBlock: cdContentBlock)
    }
}
