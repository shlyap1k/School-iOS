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
                    Image(.pencil)
                        .resizable()
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 16, height: 22)
                        .foregroundColor(.black)
                        .background(
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                                
                        )
                        .padding(4)
                }
            }
    }
}

#Preview {
    EditableCircularUserImage()
        .border(.red, width: 2)
}
