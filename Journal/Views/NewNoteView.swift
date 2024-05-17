//
//  NewNote.swift
//  Journal
//
//  Created by Tyler Lewis on 5/2/24.
//

import SwiftUI

// Unused in production app
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
            
//            NoteDetailMenu()
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


#Preview {
    NewNote()
}
