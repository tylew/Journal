//
// 21/06/2022
//
// Created by: Valerie Abelovska
// Copyright © GoodRequest s.r.o. All rights reserved.

import SwiftUI
import CoreHaptics

// Not used in final deploy, this is adapted from internet
public struct DraggingComponent: View {
    @Binding var isLocked: Bool
    let isLoading: Bool
    let maxWidth: CGFloat

    @State private var offsetX = CGFloat(10)  // The x-offset for the sliding lock image
    private let fixedHeight = CGFloat(50)  // The height of the component

    public init(isLocked: Binding<Bool>, isLoading: Bool, maxWidth: CGFloat) {
        _isLocked = isLocked
        self.isLoading = isLoading
        self.maxWidth = maxWidth
    }

    public var body: some View {
        // Background track
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appPurple.opacity(0.3))  // Background of the slider
                .frame(width: maxWidth, height: fixedHeight)

            // Sliding lock icon
            HStack {
                Text("Save").font(.system(size: 20, weight: .bold))
                Image(systemName: "arrow.right")
            }.padding(5).foregroundStyle(Color.white).background(Color.appPurple).cornerRadius(7)
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let newOffsetX = gesture.translation.width
                            if newOffsetX > 0 && newOffsetX < maxWidth - 90 { // Ensuring the lock stays within bounds
                                offsetX = newOffsetX
                            }
                        }
                        .onEnded { gesture in
                            if offsetX > maxWidth - 100 {  // Unlock threshold
                                offsetX = maxWidth - 90  // Position at the far right within bounds
                                isLocked = false
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            } else {
                                offsetX = 10  // Reset position
                                isLocked = true
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        }
            )
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.9), value: offsetX)
        .onChange(of: isLocked) { newValue in
                    if newValue {
                        offsetX = 10  // Reset position to the initial start if locked externally
                    }
                }
        .cornerRadius(16)
        .frame(width: maxWidth, height: fixedHeight)  // Ensures the container does not resize
    }
}

struct DraggingComponent_Previews: PreviewProvider {
    @State static var isLocked = true

    static var previews: some View {
        DraggingComponent(isLocked: $isLocked, isLoading: false, maxWidth: 300)
            .padding()
            .previewLayout(.sizeThatFits)
//            .background(Color.gray.opacity(0.3))
    }
}
