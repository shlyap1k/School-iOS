//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

// MARK: - LoadImage

struct LoadImage: View {
    let imageUrl: String

    var body: some View {
        if imageUrl.isValidURL {
            AsyncImage(source: .remote(url: URL(string: imageUrl))) { phase in
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
        } else {
            RoundedRectangle(cornerSize: .init(width: 8, height: 8))
                .foregroundStyle(Assets.backgroundGray.swiftUIColor)
        }
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == utf16.count
        } else {
            return false
        }
    }
}

#Preview {
    LoadImage(imageUrl: "a")
        .frame(width: 100, height: 100)
}
