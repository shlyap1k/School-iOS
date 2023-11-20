//
//  EditableCircularUserImage.swift
//  School-iOS
//
//  Created by Shlyap1k on 20.11.2023.
//

import PhotosUI
import SwiftUI

struct EditableCircularUserImage: View {
    @Binding var model: UserImageModel

    var body: some View {
        CircularUserImage(imageState: model.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(
                    selection: $model.imageSelection,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
            }
    }
}

#Preview {
    EditableCircularUserImage(model: .constant(.init()))
        .border(.red, width: 2)
}
