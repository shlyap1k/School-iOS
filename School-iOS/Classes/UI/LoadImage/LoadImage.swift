//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct LoadImage: View {
    let imageUrl: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            if let image = phase.image {
                image.resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                RoundedRectangle(cornerSize: .init(width: 8, height: 8))
                    .foregroundStyle(Assets.backgroundGray.swiftUIColor)
            } else {
                LoaderView()
            }
        }
    }
}

#Preview {
    LoadImage(imageUrl: "a")
        .frame(width: 100, height: 100)
}
