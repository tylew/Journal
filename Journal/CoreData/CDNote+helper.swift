//
//  CDNote+helper.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import Foundation
import Foundation
import CoreData

extension CDNote {
    
    public var id: UUID {
        get {
            id_ ?? UUID()
        }
    }

    
    var title: String {
        get { title_ ?? "" }
        set {
                if title_ != newValue {
                    title_ = newValue
                    updateLastModifiedDate()
                }
            }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
    }
    
    var lastModifiedDate: Date? {
        get { lastModifiedDate_ }
        set { lastModifiedDate_ = newValue }
    }

    // Handling the contentBlocks relationship
    var contentBlocks: NSOrderedSet {
            get {
                contentBlocks_ ?? NSOrderedSet()
            }
        }
    
    // Add a content block to the note
    func addContentBlock(_ block: CDContentBlock) {
        let blocks = mutableOrderedSetValue(forKey: "contentBlocks_")
        blocks.add(block)
        updateLastModifiedDate()
    }
    
    // Insert content block at index
    func insertContentBlock(_ block: CDContentBlock, at index: Int) {
        mutableOrderedSetValue(forKey: "contentBlocks_").insert(block, at: index)
        updateLastModifiedDate()
    }

    // Remove a content block from the note
    func removeContentBlock(_ block: CDContentBlock) {
        mutableSetValue(forKey: "contentBlocks_").remove(block)
        updateLastModifiedDate()
    }
    
    // Remove a content block by index
    func removeContentBlock(byIndex blockIndex: Int) {
        mutableOrderedSetValue(forKey: "contentBlocks_").removeObject(at: blockIndex)
        updateLastModifiedDate()
    }
    
    // Remove a content block by id
    func removeContentBlock(byId blockId: UUID) {
        // Retrieve the mutable ordered set proxy for the relationship
        let contentBlocksSet = mutableOrderedSetValue(forKey: "contentBlocks_")

        // Find the index of the content block with the matching UUID
        let index = contentBlocksSet.index(ofObjectPassingTest: { (obj, idx, stop) -> Bool in
            guard let contentBlock = obj as? CDContentBlock else { return false }
            if contentBlock.id == blockId {
                stop.pointee = true  // Stop the enumeration as we found our object
                return true
            }
            return false
        })

        // Check if a valid index is found
        if index != NSNotFound {
            // Remove the object at the found index
            contentBlocksSet.removeObject(at: index)
            updateLastModifiedDate()  // Update the last modified date of the parent entity
        } else {
            print("No content block found with ID: \(blockId)")
        }
    }
    
    // Updates the last modified date only if there are changes after the initial creation
    private func updateLastModifiedDate() {
        if creationDate_ != nil {
            self.lastModifiedDate_ = Date()
        }
    }

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate_ = Date()
        self.id_ = UUID()
    }
}

