//
//  NoteDetailMenu.swift
//  Journal
//
//  Created by Tyler Lewis on 5/11/24.
//

import SwiftUI
import Photos

struct NoteDetailMenu: View {
    @ObservedObject private var keyboard = KeyboardResponder()
    
//    @Binding var isFocused: Bool
    var addImageBlock: (() -> Void)?
    var addTextBlock: (() -> Void)?
    var releaseFocus: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 15) {  // Spacing between buttons
//            if isFocused {
//            if keyboard.keyboardHeight > 0 {
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
//                    .transition(AnyTransition.opacity.combined(with: .offset(x: 0, y: 40))) // Combines opacity and offset transitions
//                    .animation(.bouncy(duration: 0.3)) // Animates the transition
                //            }
//            }
            Spacer()
            // Button for adding a new entry
            Button(action: {
                print("Add new entry")
                addTextBlock?()
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 24))
            }

            // Button for saving an entry
            Button(action: {
                print("Picture")
                addImageBlock?()
                
            }) {
                Image(systemName: "photo")
                    .foregroundColor(.green)
                    .font(.system(size: 24))
            }
            

            // Button for sharing an entry
            Button(action: {
                print("Link")
            }) {
                Image(systemName: "link")
                    .foregroundColor(.purple)
                    .font(.system(size: 24))
            }
//
//            // Button for searching within the journal
////            Button(action: {
////                print("Search entries")
////            }) {
////                Image(systemName: "magnifyingglass")
////                    .foregroundColor(.red)
////                    .font(.system(size: 24))
////            }
//
//            // Button for settings or more options
//            Button(action: {
//                print("Open settings")
//            }) {
//                Image(systemName: "slider.horizontal.3")
//                    .foregroundColor(.orange)
//                    .font(.system(size: 24))
//            }
        }
        .padding(3)  // Padding around the HStack
    }
    
}
