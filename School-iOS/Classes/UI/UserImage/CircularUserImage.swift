//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct CircularUserImage: View {
    let imageState: UserImageModel.ImageState

    var body: some View {
        UserImage(imageState: imageState)
            .clipShape(Circle())
    }
}

#Preview {
    CircularUserImage(imageState: .empty)
}
