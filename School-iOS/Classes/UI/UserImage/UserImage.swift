//
// HH School
// Created by Shlyap1k.
//

import SwiftUI

struct UserImage: View {
    let imageState: UserImageModel.ImageState

    var body: some View {
        switch imageState {
        case let .success(image):
            image.getImage().resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
        case .loading:
            ProgressView()
        default:
            Image(.defaultUserpic).resizable()
                .frame(width: 120, height: 120)
        }
    }
}

#Preview {
    UserImage(imageState: UserImageModel.ImageState.empty)
}
