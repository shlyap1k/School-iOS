//
//  Avatar.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import SwiftUI

struct UserImageView: View {
    @Binding var avatar: UserImageModel

    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 120, height: 120)
            .background(
                Image(avatar.image.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipped()
            )
            .cornerRadius(120)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 120)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 1)
            )
    }
}

#Preview {
    UserImageView(avatar: .constant(UserImageModel(image: Assets.image)))
}
