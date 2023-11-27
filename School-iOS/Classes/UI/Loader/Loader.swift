//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import SwiftUI

// MARK: - LoaderView

struct LoaderView: View {
    // MARK: Lifecycle

    init(color: Color = .gray, lineWidth: CGFloat = 2.5, size: CGFloat = 25) {
        self.color = color
        self.lineWidth = lineWidth
        self.size = size
    }

    // MARK: Internal

    var color: Color
    var lineWidth: CGFloat
    var size: CGFloat

    @State var animate = false

    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .frame(width: size, height: size)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
    }
}

// MARK: - LoaderView_Preview

struct LoaderView_Preview: PreviewProvider {
    static var previews: some View {
        LoaderView()
            .background(Color.black)
    }
}
