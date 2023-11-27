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
            .frame(width: 120, height: 120)
    }
}

#Preview {
    CircularUserImage(imageState: .empty)
}
