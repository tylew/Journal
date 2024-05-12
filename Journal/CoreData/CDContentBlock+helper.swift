//
//  CDContentBlock+helper.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import Foundation
import CoreData

extension CDContentBlock {
    // UUID of the content block
    public var id: UUID {
        get {
            id_ ?? UUID()
        }
    }

    // Creation date of the content block
    var creationDate: Date {
        get {
            creationDate_ ?? Date()
        }
    }
    
    var lastModifiedDate: Date? {
        get { lastModifiedDate_ }
        set { lastModifiedDate_ = newValue }
    }
    
    // Updates the last modified date only if there are changes after the initial creation
    internal func updateLastModifiedDate() {
        if creationDate_ != nil {
            lastModifiedDate_ = Date()
        }
    }
    
    // Handling the note relationship
    var note: CDNote? {
            get {
                return note_ // Assuming 'note_' is the Core Data generated property
            }
        }
    
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id_ = UUID()
        creationDate_ = Date()  // Set the current date when the object is first inserted
    }
    
    
}

//extension CDContentBlock : Identifiable {
//    public var id: UUID {  // Make sure the type of 'id' matches what's expected in your use case
//          return self.id_  // Assuming 'uuidProperty' is the actual property in MyEntity
//       }
//}
