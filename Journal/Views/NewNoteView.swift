//
//  NewNote.swift
//  Journal
//
//  Created by Tyler Lewis on 5/2/24.
//

import SwiftUI

struct NewNote: View {
    @State private var title = ""
    @State private var content = ""
    
    @State private var isLocked = true  // State for the DraggingComponent
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .center, content: {
            HStack {
                TextField("Add a title...", text: $title)
                    .font(.system(size: 24, weight: .bold)).foregroundStyle(Color.appPurple.opacity(0.7))
                Spacer()
                Text("")
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    
                    HStack(spacing: 5, content: {
                        Text("Tag").font(.system(size: 14, weight: .light)).foregroundStyle(Color.appPurple.opacity(1))
                        Image(systemName: "paperclip.circle.fill").foregroundColor(Color.appPurple).font(.system(size: 30))
                        
                    })})
            }
            
            Spacer()
            ZStack(alignment: .topLeading) {
                Rectangle().fill(Color.appPurple)
                                        .cornerRadius(10)
                Rectangle().fill(Color(UIColor.systemBackground))
                    .cornerRadius(8).padding(2)
                
                TextField("Start typing...", text: $content, axis: .vertical)
                    .padding().foregroundStyle(Color.appPurple.opacity(1))  // Add padding inside the TextField for text
                
            }
            .frame(maxHeight: .infinity)
            
            Menu()
            // Additional UI elements could be conditionally shown based on the state
            if !isLocked {
                Text("Unlocked!")
                Button(action: {isLocked = true}, label: {
                    Text("Reset")
                })
            }
            DraggingComponent(isLocked: $isLocked, isLoading: isLoading, maxWidth: 200).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            
            
            
            
        }).padding()
    }
}

struct Menu: View {
    var body: some View {
        HStack(spacing: 15) {  // Spacing between buttons
            Button(action: {
                print("Delete entry")
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        
                    .font(.system(size: 24)).rotationEffect(Angle(degrees: 45))
                    Text("Exit").font(.system(size: 15))
                }.foregroundColor(.red)
            }
            Spacer()
            // Button for adding a new entry
            Button(action: {
                print("Add new entry")
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

#Preview {
    NewNote()
}
