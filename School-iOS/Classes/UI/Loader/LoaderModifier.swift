//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - LoadingModifier

struct LoadingModifier: ViewModifier {
    // MARK: Lifecycle

    init(isLoading: Binding<Bool>, isEmpty: Binding<Bool> = .constant(false)) {
        _isLoading = isLoading
        _isEmpty = isEmpty
    }

    // MARK: Internal

    @Binding var isLoading: Bool
    @Binding var isEmpty: Bool

    func body(content: Content) -> some View {
        content
            .overlay(alignment: isEmpty ? .center : .bottom) {
                if isLoading {
                    LoaderView()
                }
            }
    }
}

extension View {
    func isLoading(_ isLoading: Binding<Bool>, _ isEmpty: Binding<Bool>) -> some View {
        modifier(LoadingModifier(isLoading: isLoading, isEmpty: isEmpty))
    }
}
