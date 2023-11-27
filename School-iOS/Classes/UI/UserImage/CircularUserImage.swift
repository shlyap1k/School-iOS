//
//  CircularUserImage.swift
//  School-iOS
//
//  Created by Shlyap1k on 20.11.2023.
//

import SwiftUI

struct CircularUserImage: View {
    let imageState: UserImageModel.ImageState

    var body: some View {
        UserImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

#Preview {
    CircularUserImage(imageState: .empty)
}
