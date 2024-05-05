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
    
}
