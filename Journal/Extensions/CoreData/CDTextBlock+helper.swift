//
//  CDTextBlock.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import Foundation
import CoreData

// Extension for the CDTextBlock, which inherits from CDContentBlock
extension CDTextBlock {
    // Text content specific to CDTextBlock
    var text: String {
        get {
            return text_ ?? "" // Assuming 'text_' is the CoreData stored property
        }
        set {
            text_ = newValue
            super.updateLastModifiedDate()
        }
    }
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.text_ = ""
    }
    
    // CDTextBlock-specific initializer
    convenience init(context: NSManagedObjectContext, note: CDNote) {
        
        let entityName = String(describing: CDTextBlock.self)
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            fatalError("No entity found with name \(entityName)")
        }
        self.init(entity: entity, insertInto: context)
        
        self.note_ = note
        note.addContentBlock(self)
    }
}
