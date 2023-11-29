//
// HH School
// Created by Shlyap1k.
//

import PhotosUI
import SwiftUI

struct EditableCircularUserImage: View {
    @ObservedObject var model: UserImageModel = .init()

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
    EditableCircularUserImage()
        .border(.red, width: 2)
}
