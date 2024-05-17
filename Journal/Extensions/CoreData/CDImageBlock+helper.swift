//
//  CDImageBlock+helper.swift
//  Journal
//
//  Created by Tyler Lewis on 5/16/24.
//

import Foundation
import CoreData

// Extension for the CDTextBlock, which inherits from CDContentBlock
extension CDImageBlock {
    // Text content specific to CDTextBlock
    var imageData: Data {
        get {
            return imageData_ ?? Data() // Assuming 'text_' is the CoreData stored property
        }
        set {
            imageData_ = newValue
            super.updateLastModifiedDate()
        }
    }
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
    }
    
    // CDTextBlock-specific initializer
    convenience init(context: NSManagedObjectContext, note: CDNote, imagedata: Data?) {
        
        let entityName = String(describing: CDTextBlock.self)
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            fatalError("No entity found with name \(entityName)")
        }
        self.init(entity: entity, insertInto: context)
        
        self.note_ = note
        self.imageData_ = imagedata ?? Data()
        note.addContentBlock(self)
    }
}
