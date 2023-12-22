//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - AsyncImage

struct AsyncImage<Content>: View where Content: View {
    // MARK: Lifecycle

    // 4
    init(source: ImageSource, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        _loader = .init(wrappedValue: ImageLoader(source: source))
        self.content = content
    }

    // MARK: Internal

    // 5
    var body: some View {
        content(loader.phase).onAppear {
            loader.load()
        }
    }

    // MARK: Fileprivate

    // 2
    @StateObject fileprivate var loader: ImageLoader

    // MARK: Private

    // 3
    @ViewBuilder private var content: (AsyncImagePhase) -> Content
}

extension AsyncImage {
    // 1
    init<I, P>(
        source: ImageSource,
        @ViewBuilder content: @escaping (Image) -> I,
        @ViewBuilder placeholder: @escaping () -> P
    ) where
        // 2
        Content == _ConditionalContent<I, P>,
        I: View,
        P: View
    {
        self.init(source: source) { phase in
            switch phase {
            case let .success(image):
                content(image)
            case .empty, .failure:
                placeholder()
            }
        }
    }
}

// #Preview {
////    AsyncImage()
// }
