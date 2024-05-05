//
//  swipe to unlock.swift
//  Journal
//
//  Created by Tyler Lewis on 5/3/24.
//

import SwiftUI

struct swipe_to_unlock: View {
    @State private var offset = CGSize.zero  // Tracks the horizontal movement
        @State private var isUnlocked = false    // Tracks the state of the action

        var body: some View {
            VStack {
                Text(isUnlocked ? "Submitted!" : "Swipe to submit")
                    .font(.title)
//                    .foregroundColor(.white)
                    .padding()
                
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isUnlocked ? Color.green : Color.gray)
                        .frame(width: 300, height: 50)

                    // Sliding button
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .frame(width: 80, height: 50)
                        .offset(x: offset.width)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && gesture.translation.width < 220 {
                                        self.offset.width = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    if self.offset.width > 150 {
                                        self.offset.width = 220  // Lock to the right side
                                        self.isUnlocked = true
                                    } else {
                                        self.offset.width = 0  // Reset
                                        self.isUnlocked = false
                                    }
                                }
                        )
                        .animation(.easeInOut, value: offset.width)
                }
                .frame(width: 300, height: 50)
                .cornerRadius(25)
                .padding()

                if isUnlocked {
                    Button("Reset") {
                        self.offset = .zero
                        self.isUnlocked = false
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
            }
            .padding()
        }
    }

#Preview {
    swipe_to_unlock()
}
