//
//  NoteDetailMenu.swift
//  Journal
//
//  Created by Tyler Lewis on 5/11/24.
//

import SwiftUI

struct NoteDetailMenu: View {
    
//    @Binding var isFocused: Bool
    var addContentBlock: (() -> Void)?
    var releaseFocus: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 15) {  // Spacing between buttons
//            if isFocused {
                Button(action: {
                    print("Release Focus")
                    releaseFocus?()
                }) {
                    Image(systemName: "plus.circle.fill")
                    //                HStack(spacing: 4) {
                    //
                    //
                                        .font(.system(size: 24)).rotationEffect(Angle(degrees: 45))
                    //                    Text("Close").font(.system(size: 15))
                    //                }
                }.foregroundColor(.red)
//            }
            Spacer()
            // Button for adding a new entry
            Button(action: {
                print("Add new entry")
                addContentBlock?()
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 24))
            }

            // Button for saving an entry
            Button(action: {
                print("Picture")
            }) {
                Image(systemName: "photo")
                    .foregroundColor(.green)
                    .font(.system(size: 24))
            }
            

            // Button for sharing an entry
            Button(action: {
                print("Share entry")
            }) {
                Image(systemName: "link")
                    .foregroundColor(.purple)
                    .font(.system(size: 24))
            }

            // Button for searching within the journal
//            Button(action: {
//                print("Search entries")
//            }) {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(.red)
//                    .font(.system(size: 24))
//            }

            // Button for settings or more options
            Button(action: {
                print("Open settings")
            }) {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.orange)
                    .font(.system(size: 24))
            }
        }
        .padding(3)  // Padding around the HStack
    }
}
