//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct CircularUserImage: View {
    let imageState: UserImageModel.ImageState

    var body: some View {
        UserImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
    }
}

#Preview {
    CircularUserImage(imageState: .empty)
}
