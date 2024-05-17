//
//  KeyboardResponder.swift
//  Journal
//
//  Created by Tyler Lewis on 5/16/24.
//

import SwiftUI
import Combine

// Invoke this class to track notifications of keyboard activations
class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Keyboard will show notification
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { $0.height }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)

        // Keyboard will hide notification
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat.zero }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
    }
}
