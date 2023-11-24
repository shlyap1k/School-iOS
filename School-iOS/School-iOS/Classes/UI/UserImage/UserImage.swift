//
//  UserImage.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
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
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
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
