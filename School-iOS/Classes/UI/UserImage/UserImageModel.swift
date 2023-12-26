//
// HH School
// Created by Shlyap1k.
//

import CoreTransferable
import Foundation
import PhotosUI
import SwiftUI

class UserImageModel: ObservableObject {
    // MARK: Internal

    enum ImageState {
        case empty
        case loading(Progress)
        case success(ProfileImage)
        case failure(Error)
    }

    enum TransferError: Error {
        case importFailed
    }

    struct ProfileImage: Transferable {
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                return ProfileImage(image: uiImage)
            }
        }

        let image: UIImage

        func getImage() -> Image {
            Image(uiImage: image)
        }
    }

    @Published var imageState: ImageState = .empty

    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }

    // MARK: Private

    // MARK: - Private Methods

    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async { [weak self] in
                guard imageSelection == self?.imageSelection else {
                    return
                }
                switch result {
                case let .success(profileImage?):
                    self?.imageState = .success(profileImage)
                case .success(nil):
                    self?.imageState = .empty
                case let .failure(error):
                    self?.imageState = .failure(error)
                }
            }
        }
    }
}
