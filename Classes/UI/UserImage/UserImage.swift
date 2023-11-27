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
        case .loading:
            ProgressView()
        case .empty:
            Image(uiImage: Assets.defaultUserpic.image).resizable()
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    UserImage(imageState: UserImageModel.ImageState.empty)
}
